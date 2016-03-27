# Ruby
export RBENV=$HOME/.rbenv
export RUBIES=(~/.rbenv/versions/*)
## Add rbenv binaries to $PATH
export PATH=$RBENV/bin:$PATH # Add rbenv scripts to PATH
## Intialize
eval "$(rbenv init -)"
