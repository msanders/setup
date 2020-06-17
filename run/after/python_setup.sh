#!/bin/sh
eval "$(pyenv init -)"
set -o errexit

pyenv install 2.7.18 --skip-existing
pyenv install 3.6.10 --skip-existing
pyenv install 3.7.7 --skip-existing
pyenv install 3.8.3 --skip-existing

install_dependencies() {
    pip install -U pip setuptools flake8 setuptools-rust autoflake hy yapf \
        virtualenv pylint importmagic epc python-language-server
}

pyenv shell 2.7.18
install_dependencies
pyenv shell 3.6.10
install_dependencies
pyenv shell 3.7.7
install_dependencies
pyenv global 3.8.3
install_dependencies
