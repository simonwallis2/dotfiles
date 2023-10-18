#!/usr/bin/env bash
set -eu

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$SCRIPT_DIR"/lib/cecho

if [[ -f "$HOME/SystemSetup.md" ]]; then
  cecho "✔ Setup note exists at $HOME/SystemSetup.md" $green
  exit 0
fi

cat << EOF > "$HOME/SystemSetup.md"
# System Setup tasks
> Started at $(date +"%F %T %Z")

EOF

if [ "$(uname)" == "Darwin" ]; then
  cat << EOF > "$HOME/SystemSetup.md"

- [ ] Run setup scripts (\`make mac\`)
- [ ] Set up Solarized Dark profile in Terminal.app as the default
    - [ ] Reset font to Meslo LG M for Powerline after initial install
- [ ] Rename "Macintosh HD"
- [ ] Add network interface(s) to Pi-Hole Adblocking group

## System Preferences

- [ ] Walk through System Preferences, configuring as desired (see details below)

Consider running \`plistwatch\` while configuring, to capture additional scriptable configuration.

### Pay special attention to Security & Privacy, Energy, and related

- [ ] Enable FileVault
- [ ] Enable Firewall
- [ ] Allow unlocking machine with Apple Watch
- [ ] Allow apps downloaded from: App Store and identified developers
- [ ] 5 minutes to screen saver; 5 second delay before locking screen
- [ ] 2 minutes to screen off when on battery; 10 minutes on AC
- [ ] Review other Energy settings as desired
    - [ ] Enable optimizing video streaming while on battery
- [ ] Name Touch ID finger & add the other index finger
- [ ] Find My Mac & Find My Network

### Apple ID & iCloud

- [ ] Enable iCloud, except Contacts & Mail
    - [ ] Enable "Optimize Mac Storage" for iCloud Drive & Photos, as desired
    - [ ] Enable Desktop & Documents folders, as desired
- [ ] Enable Touch ID for purchases

_Note:_ After enabling iCloud Drive, you may need to re-run \`macos-homedir.sh\` and \`macos-configure-post-software-install.sh\` to create iCloud Drive links in \`~\` and configure the Finder sidebar.

### Apple Pay

- [ ] Add current cards to Apple Pay, as desired
- [ ] Set address correctly
- [ ] Set default card

### Bluetooth

- [ ] Pair AirPods Pro
- [ ] AirPods Pro: **Set to reconnect to this Mac only when last connected**

### Desktop & Screen Saver

- [ ] Customize as desired
- [ ] Install Aqueux desktops package

### Extensions

- [ ] Configure share/action extensions as desired

### Internet Accounts

- [ ] Sign into personal & work Google accounts; enable Mail/Contacts/Calendars only
    - [ ] On personal computers, for work Google account, enable *Calendar* only

### Keyboard

- [ ] Reassign Caps Lock to Ctrl
- [ ] Turn off "correct spelling automatically," "capitalize words automatically," "add period with double-space"
- [ ] Sync keyboard shortcuts configuration with current favorite system (screenshots in \`~/.config/macos\`)
    - [ ] Customize available services as desired
- [ ] Enable Dictation + Enhanced Dictation
    - [ ] Set shortcut: right Command key twice (unless keyboard has dictation key on F5)

### Network

- [ ] Add home VPN config
    - [ ] Enable 'Send All Traffic Over VPN'
- [ ] Show VPN status in menu bar; hide in Bartender Bar

### Notifications

- [ ] Disable entirely for Books, Games, Mail, Music, Reminders
- [ ] Adjust other preferences as desired

### Printers & Scanners

- [ ] Install home printer

### Sharing (as desired)

- [ ] Enable Remote Login (SSH/SFTP)

### Siri

- [ ] Disable Ask Siri

### Software Update

- [ ] Enable all options except auto-install major macOS updates

### Sound

- [ ] Alerts play through selected sound output device
- [ ] Set alert volume to ~75%

### Spotlight

- [ ] Exclude \`~/code\`, \`~/3p_code\`, \`~/go\` and any other high-churn directories

### Users & Groups

- [ ] Disable guest access
- [ ] Audit login items
- [ ] Set account photo

## Calendar

- [ ] Set default calendar (Personal or Work, depending on laptop)
- [ ] Hide native Holidays calendar (Work is the preferred Holidays calendar source)
- [ ] Refresh all accounts every 5 minutes
- [ ] Disable Time To Leave notifications
- [ ] Enable invitation notifications
- [ ] Clear all default alerts for all accounts (defaults are managed by Google Calendar instead)
- [ ] Turn on time zone support
- [ ] Default visible calendars:
    - iCloud: None
    - Personal:
        - Personal
        - TR
        - Actions
        - Environment
        - Meetups
        - Cycling
        - AADL Checkouts
        - WxCal (Google)
        - Facebook
    - Work:
        - Holidays
        - Work
    - Other:
        - Birthdays
- [ ] Disable alerts & availability for:
    - Holidays *(all copies)*
    - Environment
    - AADL Checkouts *(availability only)*
    - WxCal
    - Deliveries
    - Work / Contacts
    - Work / Team Calendar
    - Birthdays
    - Siri Suggestions
- Add to Widgets

## Dock

- [ ] Organize Dock based on screenshots in \`~/.config/macos\` (or current favorite system)

## Finder

- [ ] Configure toolbar based on screenshot in \`~/.config/macos\` (or current favorite system)
- [ ] Configure sidebar based on screenshot in \`~/.config/macos\` (or current favorite system)

## Mail

- [ ] Configure main, compose, and viewer window toolbars based on screenshots in \`~/.config/macos\` (or current favorite system)
- [ ] Check messages automatically
- [ ] Set message fonts
- [ ] Notifications: badges & notification center only; no sound
- [ ] Arrange sidebar; set Favorites

## Messages

- [ ] Sign into iCloud & enable Messages in iCloud
- [ ] Disable notifications for messages from unknown contacts
- [ ] Set Do Not Disturb for active group threads
- [ ] Enable iPhone sending SMS to this Mac
- [ ] Notifications: show previews only when unlocked
- [ ] Increase font size

## Widgets / Notification Center

- [ ] Configure: Calendar, Weather, Things, Deliveries (skip as desired for work laptop)

## Safari

- [ ] Walk through Preferences, configuring as desired
    - [ ] Set homepage: \`https://start.dzdz.cz/\`
    - [ ] New tabs and windows open with start page
    - [ ] Disable AutoFill (in favor of [1Password](https://blog.1password.com/big-sur-1password-7-7/))
    - [ ] Privacy: disable hiding IP from known trackers (breaks stuff/slows performance)
    - [ ] Enable Develop menu
- [ ] Configure toolbar based on screenshot in \`~/.config/macos\` (or current favorite system)

## Desk Setup

- [ ] Pair with Bluetooth keyboard
    - [ ] Change Caps Lock to Control in Keyboard preferences
- [ ] Run \`mouse-tracking\` script as appropriate (eg. \`mouse-tracking home\`)
- [ ] Display setup
    - [ ] Change display resolution as needed
    - [ ] Change display arrangement as needed
    - [ ] Confirm 5k/60Hz resolution via System Information app
- [ ] Pair with Sony ANC Headphones as desired

## SSH

- [ ] Verify base Git config is installed
- [ ] Clone: \`git clone https://github.com/cdzombak/sshconfig.git .ssh\`
- [ ] \`./.ssh/fix_permissions.sh\`
- [ ] Enable config templates as needed (see: Secretive or yubikey-agent setup)

## Shortcuts.app

- [ ] Add items to Menu Bar as desired
- [ ] Arrange Menu Bar icon next to FastScripts

## Stickies.app

- [ ] Set default note as floating on top & slightly larger font size (Window > Use as Default)

EOF
elif [ "$(uname)" == "Linux" ]; then
  # shellcheck disable=SC1091
  source "$SCRIPT_DIR"/linux/swprof

  cat << EOF > "$HOME/SystemSetup.md"

- [ ] Configure DNS as desired
- [ ] \`adduser cdzombak\`
- [ ] \`usermod -aG sudo cdzombak && usermod -aG admin cdzombak\`
- [ ] Set/change hostname as desired
- [ ] \`sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo reboot\`
- [ ] Add SSH key to SSH config repo
- [ ] Install SSH config
- [ ] Install dotfiles

## SSH Hardening

- [ ] Customize \`/etc/ssh/sshd_config\`:
    - \`PasswordAuthentication no\`
    - \`ChallengeResponseAuthentication no\`
    - \`PermitRootLogin no\`
    - When finished, \`sudo systemctl reload sshd\`

## Backups

- [ ] Configure and schedule backups as desired

EOF
  if is_raspbian; then
  cat << EOF > "$HOME/SystemSetup.md"

## Raspbery Pi Setup

- [ ] Configure system via \`sudo raspi-config\`
- [ ] Harden for reliability per [my blog post on reducing SD card wear](https://www.dzombak.com/blog/2021/11/Reducing-SD-Card-Wear-on-a-Raspberry-Pi-or-Armbian-Device.html)
EOF
cat << EOF > "$HOME/SystemSetup.md"

## Core Services

TODO(cdzombak): postfix, netdata, docker, logz
TODO(cdzombak): customize motd
EOF
  fi
else
  echo "System '$(uname)' unknown."
  exit 1
fi

cecho "✔ Setup note lives at $HOME/SystemSetup.md" $green
