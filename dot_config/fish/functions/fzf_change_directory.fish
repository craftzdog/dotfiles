function _list_repo_directories
    set -l ghq_root (ghq root)
    # `ghq list` walks the whole tree (~270ms); repos sit at host/owner/repo, so limit the depth.
    fd -HI -t d -t f --max-depth 4 '^\.git$' $ghq_root \
        | string replace "$ghq_root/" '' \
        | string replace -r '/\.git/?$' '' \
        | string replace -r '^github\.com/' '' \
        | sort
    set -l scratch_directories $HOME/Developments/scratch/*/
    printf '%s\n' $HOME/.config $scratch_directories | string replace -r "^$HOME" '~'
    ls -ad */ 2>/dev/null | perl -pe "s#^#$PWD/#" | grep -v \.git
end

function _resolve_repo_directory --argument-names selection
    set -l ghq_root (ghq root)
    for candidate in "$ghq_root/github.com/$selection" "$ghq_root/$selection" (string replace -r '^~' $HOME -- $selection)
        if test -d "$candidate"
            echo $candidate
            return 0
        end
    end
    return 1
end

function _fzf_change_directory
    fzf --layout reverse | read -l selection
    if test -n "$selection"; and set -l directory (_resolve_repo_directory $selection)
        builtin cd $directory
        commandline -r ''
        commandline -f repaint
    else
        commandline ''
    end
end

function fzf_change_directory
    _list_repo_directories | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end
