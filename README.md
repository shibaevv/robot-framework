# robot-framework
    ./run.sh

# install python 3
    # Windows
    export PYTHON_HOME=/c/Users/s707794/AppData/Local/Programs/Python/Python39
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
* [Installing Python 3 on Windows](https://www.python.org/downloads/windows/)
* [Installing Python 3 on Mac OS X](https://docs.python-guide.org/starting/install3/osx/)
* [Installing pip](https://pip.pypa.io/en/stable/installation/)
