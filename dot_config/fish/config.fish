set -gx LANG 'en_US.UTF-8'
set fish_greeting ""

set -gx TERM xterm-256color
#set -gx TERM tmux-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias claude-yolo "claude --dangerously-skip-permissions"
alias pn pnpm
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Rust
set -gx PATH $HOME/.cargo/bin $PATH

set -l ROOT_PATH (dirname (status --current-filename))

switch (uname)
    case Darwin
        source $ROOT_PATH/config-mac.fish
    case Linux
        source $ROOT_PATH/config-linux.fish
    case '*'
        source $ROOT_PATH/config-windows.fish
end

set LOCAL_CONFIG $ROOT_PATH/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
