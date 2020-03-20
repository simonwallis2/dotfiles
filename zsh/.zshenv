# Since .zshenv is always sourced, it often contains exported variables that should be available to other programs.
# For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv.
# Also, you can set $ZDOTDIR in .zshenv to specify an alternative location for the rest of your zsh configuration.

if [ -x /usr/libexec/path_helper ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# Android (ugh)
if [ -d "$HOME/Library/Android/sdk" ]; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH="$PATH:$ANDROID_HOME/emulator"
    export PATH="$PATH:$ANDROID_HOME/tools"
    export PATH="$PATH:$ANDROID_HOME/tools/bin"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"
fi

# Golang:
export GOROOT=/usr/local/opt/go/libexec
export PATH="$GOROOT/bin:$PATH"
if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

# Rust:
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Fastlane (brew cask install fastlane):
if [ -d "$HOME/.fastlane/bin" ]; then
    export PATH="$PATH:$HOME/.fastlane/bin"
fi

if [ -d "/usr/local/Caskroom/google-cloud-sdk/" ] ; then
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
fi

# Homebrew:
# Python has been installed as
#   /usr/local/bin/python3
# Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
# `python3`, `python3-config`, `pip3` etc., respectively, have been installed into
#   /usr/local/opt/python/libexec/bin
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# allow installing in ~/opt:
# export LD_LIBRARY_PATH="$HOME/opt/lib/:$LD_LIBRARY_PATH"
export PATH="$HOME/opt/sbin:$HOME/opt/bin:$PATH"
export MANPATH="$HOME/opt/share/man:$MANPATH"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

export PIP_RESPECT_VIRTUALENV=true
export PIP_REQUIRE_VIRTUALENV="1"

source ~/.zsh/fn-default.zsh

env_default PAGER 'less'
env_default LESS '-R'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ ! -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]; then
    export EDITOR='nano -w' # if we're in an SSH session or Sublime is missing
else
    export EDITOR='subl -w -n' # sublime; wait; new window
fi
