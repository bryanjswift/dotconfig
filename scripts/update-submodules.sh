#!/bin/sh

# Use this rather than `git submodle foreach` because the git submodules do not
# all have the same "upstream" branch name.
for sm in $(git submodule | cut -d ' ' -f 3); do
  cd $sm
  echo "Entering $sm"
  git fetch origin --prune
  git merge --ff-only $(git branch -a | grep 'remotes\/origin\/\(main\|master\)' | cut -c11-)
  cd -
done
