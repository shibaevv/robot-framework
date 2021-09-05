# robot-framework
    ./run.sh
    ./run.sh collections/sample/APITests.robot

# Install python 3
    # Windows (admin) - Installing Python 3 on Windows
    Download Windows installer (64-bit)
    
    # Windows (embeddable) - Installing Python 3 on Windows
    Download Windows embeddable package (64-bit)
    # Setting up python's Windows embeddable distribution
    # Download get-pip.py at https://bootstrap.pypa.io/get-pip.py to PYTHON_HOME and run
    $PYTHON_HOME/get-pip.py
    # Config path
    # edit $PYTHON_HOME/python37._pth (Uncomment the line #import site and save)
    # create $PYTHON_HOME/sitecustomize.py with these 2 lines:
    # import sys
    # sys.path.insert(0, '')

# Configure python 3
    # Windows (git bash)
    # vi ~/.bashrc
    export PYTHON_HOME=/c/Users/<user>/AppData/Local/Programs/Python/Python39
    export PATH=$PYTHON_HOME:$PYTHON_HOME/Scripts:$PATH
    
    # OSX - Installing Python 3 on Mac OS X
    brew install python
    python --version
    # vi ~/.zshrc
    # export PATH=/usr/local/opt/python/libexec/bin:$PATH
    
    # test install
    python --version

# install pip (should be installed with python)
    # python -m ensurepip --upgrade
    # python -m pip install --upgrade pip
    pip --version

# install/run pip tools
    python -m pip install pip-tools
    pip-compile requirements.in
    pip install -r requirements.txt

# References
1. [Robot Framework](https://robotframework.org/)
2. [Installing Python 3 on Windows](https://www.python.org/downloads/windows/)
3. [Setting up python's Windows embeddable distribution](https://dev.to/fpim/setting-up-python-s-windows-embeddable-distribution-properly-1081)
4. [Installing Python 3 on Mac OS X](https://docs.python-guide.org/starting/install3/osx/)
5. [Installing pip](https://pip.pypa.io/en/stable/installation/)

# Libraries:
* [ConfluentKafkaLibrary](https://github.com/robooo/robotframework-ConfluentKafkaLibrary)
* [ConfluentKafkaLibrary API](https://robooo.github.io/robotframework-ConfluentKafkaLibrary/)
* [confluent_kafka API](https://docs.confluent.io/platform/current/clients/confluent-kafka-python/html/index.html)

