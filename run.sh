#!/bin/bash -e

# ./run.sh
# ./run.sh collections/XXX.robot
#
# Run the python tests
# Expected environment variables:
# TEST_ENVIRONMENT: the environment to test
# test_origin: the place where the tests are executed: internet or extranet

SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
#ROOT_DIR="$(cd $SCRIPT_DIR && pwd -P)"
TEST_REPORT_DIR='test_report'

function clean() {
  echo "Cleaning config/test data and test report dir"
  rm -rf tmp/ "$TEST_REPORT_DIR"
}

function s3_upload() {
  if [ "${upload}" == "true" ]; then
    echo "Test reports are being uploaded to s3"
    # TODO parameterise build_data_stackname
    local build_data_stackname="ci-build-system-data"
    local CommitId="$(date)"
    local test_bucket=s3://"${aws_ci_build_account_id}"-"${build_data_stackname}"-test-reports
    # DeploymentId to be added to s3_test_report_path once implemented with other aspects of the pipeline.
    local s3_test_report_path="${test_bucket}/${CommitId}/${test_environment}/${test_origin}/"
    aws s3 sync "$TEST_REPORT_DIR" "${s3_test_report_path}"
  fi
}

function run_collection() {
  local collection="$1"
  shift
  local collection_name=$(basename $collection .robot)
  local report_file="$TEST_REPORT_DIR/$(date +'%H:%M:%S')_${collection_name}.typescript"
  local verbose

  if [ -n "$VERBOSE" ] ; then
    verbose='-v'
  fi
  echo "Running collection - $collection"
  ROBOT_OPTS="-d $TEST_REPORT_DIR/$collection"
  robot_command="robot $ROBOT_OPTS $collection"
  # Execute `script` based on OS
  if [ $(uname) == "Linux" ]; then
    { # try
      script -c "$robot_command" --return "$report_file"  # Linux `script`
    } || { # catch
      # save log for exception
      #ex_code = $?
      echo ">>> $robot_command failed."
    }
  elif [ $(uname) == "Darwin" ]; then
    script $report_file $robot_command  # BSD `script`
  else
    { # try
      bash -c "$robot_command" --return "$report_file"  # MINGW64 `script`
    } || { # catch
      # save log for exception
      #ex_code = $?
      echo ">>> $robot_command failed."
    }
  fi
  ret="$?"
  rc=$(( ${rc} + ${ret} ))
  if [ "${ret}" -ne 0 ]; then
    test_recap+=( "${collection}: FAILURE" )
  else
    test_recap+=( "${collection}: SUCCESS" )
  fi
  if [ "${report}" == "true" ]; then
    echo "Your ${collection} collection report has been saved to $report_file"
  fi
}

function main() {
  collection=$1
  export test_environment=${TEST_ENVIRONMENT:-dev}
  export test_origin=${test_origin:-internet}
  if [ $(uname) == "Darwin" ]; then
    #export AWS_PROFILE=dev
    # allow multithreading applications or scripts under the new macOS High Sierra security rules
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
  fi
  echo  "Running $(python --version) tests in $test_environment from $test_origin"

  # auto export all variables
  set -a
  source ./config/${test_environment}.cfg
  set +a

  local rc=0
  declare -a test_recap=()
  mkdir -p $TEST_REPORT_DIR
  if [ $(uname) == "Linux" ]; then
    trap clean EXIT
  fi

  # initialise
  if [ $(uname) == "Linux" ]; then
    echo $(whoami)
    echo $(uname -a)
    echo $(cat /etc/os-release)
    #amazon-linux-extras install epel -y
    yum install -y chromium
    echo " --no-sandbox" >> /usr/bin/chromium-browser

    pip install -r requirements.txt

    # https://robotframework.org/SeleniumLibrary/
    webdrivermanager chrome --linkpath /usr/local/bin
    echo $(chromedriver -v)
  elif [ $(uname) == "Darwin" ]; then
    echo "manual install for $(uname)"
    # pip install -r requirements.txt
  else
    echo "manual install for $(uname)"
    # pip install -r requirements.txt
  fi
  echo $(robot --version)
  echo $(rebot --version)

  set +e
  if [ "${test_origin}" == "internet" ]; then
    if [ -z $collection ]; then
      #for collection in $( find collections -name '*.robot' | sort -r ) ; do
      for collection in $( find collections -name '*.robot' -not -path 'collections/sample/*' | sort ) ; do
        run_collection $collection
      done
    else
      run_collection $collection
    fi
  elif [ "${test_origin}" == "extranet" ]; then
    # unfortunately "requests" does not handle encrypted keys so decrypt it first
    export KEY_PATH="$SCRIPT_DIR/ssl/extranet_ssl.unencrypted.key.pem"
    export CERT_PATH="$SCRIPT_DIR/ssl/extranet_ssl.pem"
    if [ -z $collection ]; then
      for collection in $( find collections -name '*.robot' -not -path 'collections/sample/*' | sort ) ; do
        run_collection $collection
      done
    else
      run_collection $collection
    fi
  else
    echo "Unsupported test origin: ${test_origin}"
    exit 1
  fi
  set -e

  if [ "${rc}" == 0 ]; then
      echo "All the tests passed successfully !"
  else
      echo "ERROR: some tests failed ! Please check the report above ^"
      echo "Recap of the collections results:"
      printf "%s\n" "${test_recap[@]}"
  fi
  if [ "${upload}" = "true" -a "${report}" = "true" ]; then
    s3_upload
  fi
  exit ${rc}
}

main "$@"
