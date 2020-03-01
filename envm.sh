#!/bin/bash

print_help() {
  # check for too less or to much args and exit appropriately
  if [[ $# -le 1 || $# -gt 2 || $1 == "--help" ]]; then
    printf '%s\n\n' "env M anager at your disposal ;)"
    printf '%s\n' "Usage:"
    printf '%s\n\n' " envm [--flag]"
    printf '%s\n' "Flags:"
    printf '%s\n\n' " --help help for this bash script"
    printf '%s\n\n' " --update manual update for envm"
    exit 1
  fi
}

if [[ $1 == "--update" ]]; then
  echo "Updating"
  figlet "env M anager..."
  cd $envm
  git ch master && git pull --rebase --stat origin master
  cd $envm_wdir
  .$envm/setup.sh
  exec $SHELL -l
else
  print_help
fi

