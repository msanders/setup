#!/bin/sh
eval "$(pyenv init -)"
set -o errexit

pyenv install 2.7.18 --skip-existing
pyenv install 3.6.11 --skip-existing
pyenv install 3.7.8 --skip-existing
pyenv install 3.8.5 --skip-existing

install_common_dependencies() {
    pip install -U pip setuptools virtualenv pipenv pytest nose pyflakes isort \
        setuptools-rust
}

install_py3_dependencies() {
    pip install -U black
}

pyenv shell 2.7.18
install_common_dependencies
pyenv shell 3.6.11
install_common_dependencies
install_py3_dependencies
pyenv shell 3.7.8
install_common_dependencies
install_py3_dependencies
pyenv shell 3.8.5
install_common_dependencies
install_py3_dependencies
pyenv global 3.8.5
