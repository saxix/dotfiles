_pipenv_completion() {
    local IFS=$'\t'
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _PIPENV_COMPLETE=complete-bash $1 ) )
    return 0
}

complete -F _pipenv_completion -o default pipenv
complete -F _pipenv_completion -o default pe
