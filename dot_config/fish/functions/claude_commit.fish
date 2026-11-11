function claude_commit --description 'Commit with the Claude Code craftzdog:commit skill, printing progress as it runs'
    set -l progress_filter '
        if .type == "system" and .subtype == "init" then "● Claude Code started"
        elif .type == "assistant" then
            .message.content[]
            | if .type == "thinking" then "● Thinking…"
              elif .type == "tool_use" then "$ " + (.input.command // .name)
              elif .type == "text" then "\n" + .text
              else empty end
        elif .type == "user" then
            .message.content[]?
            | select(.type == "tool_result")
            | .content
            | if type == "array" then map(.text // "") | join("\n") else tostring end
        else empty end'

    claude -p "/craftzdog:commit" \
        --allowedTools "Bash(git commit:*)" "Bash(git add:*)" \
        --output-format stream-json --verbose </dev/null \
        | jq --unbuffered -r $progress_filter
end
