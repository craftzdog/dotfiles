if type -q eza
    alias ll "eza -l -g --icons=auto"
    alias lla "ll -a"
end

if type -q bat
    alias bat "bat --theme \"Solarized (dark)\""
    alias less bat
end

# Homebrew
set -gx PATH /opt/homebrew/bin $PATH

# Android SDK
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/platform-tools

# React Native Editor
set -xg REACT_EDITOR subl

# Java
set ANDROID_JAVA_HOME /Applications/Android\ Studio.app/Contents/jbr/Contents/Home
if test -f $ANDROID_JAVA_HOME/bin/java
    set -gx JAVA_HOME $ANDROID_JAVA_HOME
else if test -f /usr/libexec/java_home
    set -gx JAVA_HOME (/usr/libexec/java_home -v 17)
end

# inkdrop
set -gx INKDROP_HOME ~/.inkdrop

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
set -g FZF_ENABLE_OPEN_PREVIEW 1
# Tab completion
#set -U FZF_COMPLETE 2
