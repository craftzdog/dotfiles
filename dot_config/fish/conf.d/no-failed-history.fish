# Drop failed commands from history: after a command runs, if it exited
# non-zero, delete it from history (in-memory and on disk). fish adds a
# command to history *before* running it, so this must run in fish_postexec —
# fish_should_add_to_history fires too early to see $status.
function __remove_failed_from_history --on-event fish_postexec
    set -l last_status $status
    if test $last_status -ne 0
        builtin history delete --exact --case-sensitive -- $argv[1]
    end
end
