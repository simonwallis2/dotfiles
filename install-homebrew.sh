#!/usr/bin/env bash

# On macOS systems, verify Homebrew is installed, and install it if not.

set -euo pipefail
IFS=$'\n\t'

if [ "$(uname)" != "Darwin" ]; then
  echo "Skipping Homebrew setup because not on macOS"
  exit 0
fi

command -v brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
