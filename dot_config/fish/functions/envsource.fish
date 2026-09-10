# From https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc

function envsource
    for line in (cat $argv | grep -v '^#')
        set item (string split -m 1 '=' $line)
        set -gx $item[1] $item[2]
        echo "Exported key $item[1]"
    end
end
