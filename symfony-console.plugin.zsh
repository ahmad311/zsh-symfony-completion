_symfony_console_all_commands() {
    local command

    if type "$words[1]" &> /dev/null; then
        command=$words
    elif [ -f "./$words[1]" ]; then
        command=('php' $words)
    else
        return
    fi

    eval "$command" | sed "1,/Available commands/d" | grep "^\s.*\s.*$" | sed 's/:/\\:/' | sed -E "s/ *([a-z:\\-]+) *(.*)/\1:\2/"
}

_symfony_console_describe() {
    local suggestions

    suggestions=("${(@f)$(_symfony_console_all_commands)}")

    _describe -t commands "command subcommand" suggestions
}

tools=("${(@s/ /)SYMFONY_CONSOLE_TOOLS}")

compdef _symfony_console_describe $tools