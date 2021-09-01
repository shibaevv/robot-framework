# robot-framework
    ./run.sh

# install python 3
    # Windows
    export PYTHON_HOME=/c/Users/<user>/AppData/Local/Programs/Python/Python39
    export PATH=$PYTHON_HOME:$PYTHON_HOME/Scripts:$PATH
    python --version
    
    # OSX
    brew install python
    python --version
    # vi ~/.zshrc
    # export PATH=/usr/local/opt/python/libexec/bin:$PATH

# install pip (should be installed with python)
    # python -m ensurepip --upgrade
    # python -m pip install --upgrade pip

# install/run pip tools
    python -m pip install pip-tools
    pip-compile requirements.in
    pip install -r requirements.txt

# References
* [Robot Framework](https://robotframework.org/)
* [Installing Python 3 on Windows](https://www.python.org/downloads/windows/)
* [Installing Python 3 on Mac OS X](https://docs.python-guide.org/starting/install3/osx/)
* [Setting up python's Windows embeddable distribution](https://dev.to/fpim/setting-up-python-s-windows-embeddable-distribution-properly-1081)
* [Installing pip](https://pip.pypa.io/en/stable/installation/)

# Libraries:
* [ConfluentKafkaLibrary](https://github.com/robooo/robotframework-ConfluentKafkaLibrary)
* [ConfluentKafkaLibrary API](https://robooo.github.io/robotframework-ConfluentKafkaLibrary/)
* [confluent_kafka API](https://docs.confluent.io/platform/current/clients/confluent-kafka-python/html/index.html)

