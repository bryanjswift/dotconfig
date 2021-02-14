# Python
export PYENV=$(pyenv root)
export PYENV_VERSIONS=(${PYENV}/versions/*)
## Add pyenv binaries to $PATH
export PATH="${PYENV}/bin:${PATH}"
## Intialize
eval "$(pyenv init -)"
