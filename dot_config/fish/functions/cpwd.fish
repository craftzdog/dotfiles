function cpwd --description 'Copy the current directory to the clipboard, with $HOME as ~'
    printf '%s' (string replace -r "^$HOME" '~' -- $PWD) | pbcopy
end
