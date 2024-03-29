#!/usr/bin/env zsh
#
# This lets you quickly jump into a project directory.
#
# Type:
#
#   c <tab>
#
# ...to autocomplete on all of your projects in the directories specified in
# `functions/_c`. Typically I am using it like:
#
#    c holm<tab>/bo<tab>
#
# ...to quickly jump into holman/boom, for example.
#
# This also accounts for how Go structures its projects. For example, it will
# autocomplete both on $PROJECTS, and also assume you want to autocomplete on
# your Go projects in $GOPATH/src.

# Set the $PROJECTS variable to the directory where you keep all of your code.
if [ -z "$PROJECTS" ]; then
  export PROJECTS=~/Code
fi

c() {
  if [ -z "$1" ]; then
    cd $PROJECTS
    return
  fi

  if git config --global --get ghq.root >> /dev/null; then
    ghqRoot=$(git config --global --get ghq.root)
    if [ -d "${ghqRoot}/github.com/${1}" ]; then
      cd "${ghqRoot}/github.com/${1}"
      return
    elif [ -d "${ghqRoot}/gitlab.com/${1}" ]; then
      cd "${ghqRoot}/gitlab.com/${1}"
      return
    elif [ -d "$ghqRoot/${1}" ]; then
      cd "${ghqRoot}/${1}"
      return
    fi
  fi

  cd "${PROJECTS}/${1}"
}
