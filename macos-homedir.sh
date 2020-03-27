#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "$(uname)" != "Darwin" ]; then
  echo "Skipping macOS homedir setup because not on macOS"
  exit 2
fi

mkdir -p "$HOME/.local/dotfiles"
mkdir -p "$HOME/.local/shell-completion"
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/code"
mkdir -p "$HOME/opt/bin"
mkdir -p "$HOME/opt/lib"
mkdir -p "$HOME/opt/sbin"
mkdir -p "$HOME/opt/share/man"
mkdir -p "$HOME/tmp"

if [ -d "$HOME/.shell-completion-local" ]; then
  if find "$HOME/.shell-completion-local" -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
    cp -R "$HOME/.shell-completion-local/"* "$HOME/.local/shell-completion"
  fi
  trash "$HOME/.shell-completion-local"
fi

if [ ! -d "$HOME/go" ] && [ ! -e "$HOME/.local/dotfiles/no-home-go-dir" ] ; then
  echo ""
  echo "Create ~/go/bin and ~/go/src? (y/N)"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    mkdir -p "$HOME/go/bin"
    mkdir -p "$HOME/go/src"
  else
    touch "$HOME/.local/dotfiles/no-home-go-dir"
  fi
fi

# Integrate iCloud Drive & Syncthing into ~ via symlinks:
# even if Syncthing isn't setup yet, create broken links to ~/Sync; they'll work later

if [ ! -L "$HOME/iCloud Drive" ]; then
  ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs" "$HOME/iCloud Drive"
fi

if [ ! -L "$HOME/Dropbox" ]; then
  ln -s "$HOME/Sync" "$HOME/Dropbox"
  chflags -h hidden "$HOME/Dropbox"
fi

if [ ! -L "$HOME/env" ]; then
  ln -s "$HOME/Sync/env" "$HOME/env"
fi

if [ ! -L "$HOME/Public/burr" ]; then
  ln -s "$HOME/Sync/public" "$HOME/Public/burr"
fi

if [ ! -L "$HOME/Applications/macOS Utilities" ]; then
  ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Software/macOS Utilities" "$HOME/Applications/macOS Utilities"
fi

if [ ! -L "$HOME/Applications/macOS Security Tools" ]; then
  ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Software/macOS Security Tools" "$HOME/Applications/macOS Security Tools"
fi

if [ ! -L "$HOME/Downloads/iCloud" ]; then
  ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Downloads" "$HOME/Downloads/iCloud"
fi

if [ ! -L "$HOME/Pictures/iCloud" ]; then
  ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Pictures" "$HOME/Pictures/iCloud"
fi

if [ ! -L "$HOME/Books and Articles" ] && [ ! -e "$HOME/.local/dotfiles/no-home-booksandarticles-dir" ] ; then
  echo ""
  echo "Create link to iCloud Drive/Books & Articles in home directory? (y/N)"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Library" "$HOME/Books and Articles"
  else
    touch "$HOME/.local/dotfiles/no-home-booksandarticles-dir"
  fi
fi

if ! diff -r "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/" "$HOME/Documents" >/dev/null ; then
  if { [ ! -L "$HOME/Desktop/iCloud" ] || [ ! -L "$HOME/Documents/iCloud" ] ;} && [ ! -e "$HOME/.local/dotfiles/no-home-icloud-links" ]; then
    echo ""
    echo "Desktop/Documents in iCloud appears to be disabled."
    echo "Create links from Desktop/Documents to iCloud Drive? (y/N)"
    echo "(eg. ~/Documents/iCloud, etc. Mainly intended for work computers.)"
    read -r response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
      ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Desktop" "$HOME/Desktop/iCloud"
      ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents" "$HOME/Documents/iCloud"
    else
      touch "$HOME/.local/dotfiles/no-home-icloud-links"
    fi
  fi
fi

# JetBrains IDE directory shortcuts:

if [ ! -L "$HOME/Applications/toolbox-androidstudio" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio" "$HOME/Applications/toolbox-androidstudio"
fi
if [ ! -L "$HOME/Applications/toolbox-goland" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/Goland" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/Goland" "$HOME/Applications/toolbox-goland"
fi
if [ ! -L "$HOME/Applications/toolbox-idea" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/IDEA-U" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/IDEA-U" "$HOME/Applications/toolbox-idea"
fi
if [ ! -L "$HOME/Applications/toolbox-pycharm" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/PyCharm-P" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/PyCharm-P" "$HOME/Applications/toolbox-pycharm"
fi
if [ ! -L "$HOME/Applications/toolbox-webstorm" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/WebStorm" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/WebStorm" "$HOME/Applications/toolbox-webstorm"
fi
