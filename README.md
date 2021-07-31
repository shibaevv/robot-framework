# robot-framework
    ./run.sh

# install python 3
    # OSX
    brew install python
    python --version
    # python -m ensurepip --upgrade
    # python -m pip install --upgrade pip
    # vi ~/.zshrc
    # export PATH=/usr/local/opt/python/libexec/bin:$PATH
    #
    python -m pip install pip-tools
    pip-compile requirements.in
    pip install -r requirements.txt

# References
* [Installing Python 3 on Mac OS X](https://docs.python-guide.org/starting/install3/osx/)
* [Installing pip](https://pip.pypa.io/en/stable/installation/)
