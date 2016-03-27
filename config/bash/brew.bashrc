# Homebrew
export CELLAR=`brew --cellar`
## Environment Variables for JVM Development
# TODO: Check ant is installed
export ANT_HOME=$(brew --cellar ant)/1.9.3
## Autocomplete
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
