#!/bin/sh
eval "$(pyenv init -)"
set -o errexit

pyenv install 2.7.18 --skip-existing
pyenv install 3.6.12 --skip-existing
pyenv install 3.7.9 --skip-existing
pyenv install 3.8.6 --skip-existing
pyenv install 3.9.0 --skip-existing

install_common_dependencies() {
    pip install -U pip setuptools virtualenv pipenv pytest nose pyflakes isort \
        setuptools-rust
}

install_py3_dependencies() {
    pip install -U black
}

pyenv shell 2.7.18
install_common_dependencies
pyenv shell 3.6.12
install_common_dependencies
install_py3_dependencies
pyenv shell 3.7.9
install_common_dependencies
install_py3_dependencies
pyenv shell 3.8.6
install_common_dependencies
install_py3_dependencies
pyenv shell 3.9.0
install_common_dependencies
install_py3_dependencies
pyenv global 3.9.0
