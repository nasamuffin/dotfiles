#!/bin/bash

# Author: Emily Shaffer (2020)

# Opens vim to a given file and line number.
# $1 = file
# $2 = line number
# $3+ discarded
function open_vim_to_loc {
  vim +"$2" "$1"
}

function show_vim_loc {
  echo +"$2" "$1"
}

if [[ -z "$@" ]]; then
  echo "usage: vimdef <full-fn-name> [<git grep arg>...]"
  exit
fi

# A definition has some types at the very front of the line, separated by one
# whitespace each, then the function name. The types might be pointers, and the
# pointers might be on the right side of the space instead. The pointers might
# also be double pointers or more. If it returns a struct or enum, there might
# be an underscore in the type name at the front.
# It takes the form of <filename>:<line>:<matched-string>
DEF="$(git grep -E -e "^([a-z_]+\** )+\**$1\(" "${@:2}" -- ":!*.h*")"

# If there wasn't a match, this might be a macro.
if [[ -z "$DEF" ]]; then
  DEF="$(git grep -E -e "^#define $1\(" "${@:2}")"
fi

if [[ -z "$DEF" ]]; then
  git grep $1
  exit
fi

# Don't quote $() because we want it interpreted as separate args.
if [[ "$VIMDEF_FROM_VIM" ]]; then
  show_vim_loc $(echo $DEF | tr ':' ' ')
else
  open_vim_to_loc $(echo $DEF | tr ':' ' ')
fi
