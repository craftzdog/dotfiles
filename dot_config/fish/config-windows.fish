set SSH_AGENT_CONFIG (dirname (status --current-filename))/conf.d/fish-ssh-agent_init.fish
if test -f $SSH_AGENT_CONFIG
    source $SSH_AGENT_CONFIG
end
