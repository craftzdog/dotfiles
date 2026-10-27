function fish_user_key_bindings
    # fzf
    bind \cf fzf_change_directory

    # prevent iterm2 from closing when typing Ctrl-D (EOF)
    bind \cd delete-char
end

# fzf plugin
fzf_configure_bindings --directory=\co
