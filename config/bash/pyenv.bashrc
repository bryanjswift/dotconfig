# Python
export PYENV_ROOT=$(pyenv root)
export PYENV_VERSIONS=(${PYENV_ROOT}/versions/*)
## Add pyenv binaries to $PATH
export PATH="${PYENV_ROOT}/bin:${PATH}"
## Intialize
eval "$(pyenv init --path)"
