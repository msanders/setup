#!/bin/sh
eval "$(pyenv init -)"
set -o errexit

if [ "$(uname -s)" = "Darwin" ]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
else
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
fi

pyenv install 2.7.17 --skip-existing
pyenv install 3.6.9 --skip-existing
pyenv install 3.7.5 --skip-existing
pyenv install 3.8.0 --skip-existing

install_dependencies() {
    pip install -U pip setuptools flake8 setuptools-rust autoflake hy yapf \
                   virtualenv pylint
}

pyenv shell 2.7.17
install_dependencies
pyenv shell 3.6.9
install_dependencies
pyenv shell 3.7.5
install_dependencies
pyenv global 3.8.0
install_dependencies
