#!/bin/bash
#
# Convert an up to 4 digit semversion i.j.k.l with up to 3 digits each part to
# an integer value.
#
# Inspired by: https://stackoverflow.com/a/37939589/15763374
#
# Usage:
#   if [ $(semver2int $VAR) -ge $(semver2int "6.2.0") ]; then
#     echo "Version is up to date"
#   fi
#
semver2int() {
  if [[ -n "$1" && ! "$1" =~ ^[0-9]+(\.[0-9]{1,3}){0,3}$ ]]; then
    echo "##### $0: '$1' is an invalid version for this script! It must be up to 4 numeric parts separated by '.' and up to 3 digits for each part!" >&2
    exit 1
  fi
  echo "$1" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

semver2int $1
if [[ -n "$2" ]]; then
  semver2int $2
  if [[ $(semver2int "$1") -gt $(semver2int "$2") ]]; then
    echo "Version '$1' is GREATER than '$2'!"
  fi
  if [[ $(semver2int "$1") -lt $(semver2int "$2") ]]; then
    echo "Version '$1' is LOWER than '$2'!"
  fi
  if [[ $(semver2int "$1") -eq $(semver2int "$2") ]]; then
    echo "Version '$1' is EQUAL to '$2'!"
  fi
fi
