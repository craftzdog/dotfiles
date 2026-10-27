function _fzf_change_directory
    fzf --layout reverse | perl -pe 's/([ ()])/\\\\$1/g' | read foo
    if [ $foo ]
        builtin cd $foo
        commandline -r ''
        commandline -f repaint
    else
        commandline ''
    end
end

function fzf_change_directory
    begin
        echo $HOME/.config
        find $(ghq root) -maxdepth 4 -type d -name .git | sed 's/\/\.git//'
        fd . (gwq config get worktree.basedir | string replace '~' $HOME) -t d --max-depth 3 --min-depth 3
        ls -ad */ | perl -pe "s#^#$PWD/#" | grep -v \.git
        ls -ad $HOME/Developments/*/* | grep -v \.git
    end | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end
