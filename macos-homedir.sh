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

if [ ! -d "$HOME/code" ] && [ ! -e "$HOME/.local/dotfiles/no-home-code-dir" ] ; then
  echo ""
  echo "Create ~/code and ~/3p_code? (y/N)"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    mkdir -p "$HOME/3p_code"
    mkdir -p "$HOME/code"
  else
    touch "$HOME/.local/dotfiles/no-home-code-dir"
  fi
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

ICLOUD_DRIVE_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
if [ -d "$HOME/Library/CloudStorage/iCloudDrive" ]; then
  # new path for Catalina/Big Sur and newer
  # https://github.com/cdzombak/dotfiles/issues/20
  ICLOUD_DRIVE_DIR="$HOME/Library/CloudStorage/iCloudDrive"
else
  echo "[note!] Using pre-Catalina iCloud Drive path."
  echo "        If this is a newer OS, these links won't work and will need to be migrated."
fi

if [ ! -L "$HOME/iCloud Drive" ]; then
  ln -s "$ICLOUD_DRIVE_DIR" "$HOME/iCloud Drive"
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
  ln -s "$ICLOUD_DRIVE_DIR/Software/macOS Utilities" "$HOME/Applications/macOS Utilities"
fi

if [ ! -L "$HOME/Applications/macOS Security Tools" ]; then
  ln -s "$ICLOUD_DRIVE_DIR/Software/macOS Security Tools" "$HOME/Applications/macOS Security Tools"
fi

if [ ! -L "$HOME/Downloads/iCloud" ]; then
  ln -s "$ICLOUD_DRIVE_DIR/Downloads" "$HOME/Downloads/iCloud"
fi

if [ ! -L "$HOME/Pictures/iCloud" ]; then
  ln -s "$ICLOUD_DRIVE_DIR/Pictures" "$HOME/Pictures/iCloud"
fi

if [ ! -L "$HOME/tmp/iCloud" ]; then
  ln -s "$ICLOUD_DRIVE_DIR/Temp" "$HOME/tmp/iCloud"
fi

if [ ! -L "$HOME/Books and Articles" ] && [ ! -e "$HOME/.local/dotfiles/no-home-booksandarticles-dir" ] ; then
  echo ""
  echo "Create link to iCloud Drive/Books & Articles in home directory? (y/N)"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    ln -s "$ICLOUD_DRIVE_DIR/Library" "$HOME/Books and Articles"
  else
    touch "$HOME/.local/dotfiles/no-home-booksandarticles-dir"
  fi
fi

if ! diff -r "$ICLOUD_DRIVE_DIR/Documents/" "$HOME/Documents" >/dev/null ; then
  if { [ ! -L "$HOME/Desktop/iCloud" ] || [ ! -L "$HOME/Documents/iCloud" ] ;} && [ ! -e "$HOME/.local/dotfiles/no-home-icloud-links" ]; then
    echo ""
    echo "Desktop/Documents in iCloud appears to be disabled."
    echo "Create links from Desktop/Documents to iCloud Drive? (y/N)"
    echo "(eg. ~/Documents/iCloud, etc. Mainly intended for work computers.)"
    read -r response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
      ln -s "$ICLOUD_DRIVE_DIR/Desktop" "$HOME/Desktop/iCloud"
      ln -s "$ICLOUD_DRIVE_DIR/Documents" "$HOME/Documents/iCloud"
    else
      touch "$HOME/.local/dotfiles/no-home-icloud-links"
    fi
  fi
fi

# JetBrains IDE directory shortcuts:

if [ ! -L "$HOME/Applications/toolbox-androidstudio" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio/ch-0" "$HOME/Applications/toolbox-androidstudio"
fi
if [ ! -L "$HOME/Applications/toolbox-clion" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/CLion" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/CLion/ch-0" "$HOME/Applications/toolbox-clion"
fi
if [ ! -L "$HOME/Applications/toolbox-datagrip" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/datagrip" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/datagrip/ch-0" "$HOME/Applications/toolbox-datagrip"
fi
if [ ! -L "$HOME/Applications/toolbox-goland" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/Goland" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/Goland/ch-0" "$HOME/Applications/toolbox-goland"
fi
if [ ! -L "$HOME/Applications/toolbox-idea" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/IDEA-U" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/IDEA-U/ch-0" "$HOME/Applications/toolbox-idea"
fi
if [ ! -L "$HOME/Applications/toolbox-pycharm" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/PyCharm-P" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/PyCharm-P/ch-0" "$HOME/Applications/toolbox-pycharm"
fi
if [ ! -L "$HOME/Applications/toolbox-webstorm" ] && [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/apps/WebStorm" ]; then
  ln -s "$HOME/Library/Application Support/JetBrains/Toolbox/apps/WebStorm/ch-0" "$HOME/Applications/toolbox-webstorm"
fi
