_tox_completion()
{
    local cur prev opts
    prev=${COMP_WORDS[COMP_CWORD-1]}
    cur=`_get_cword`
    local cur_="${3-$cur}"
    if [[ "$cur_" == -e ]]; then
        # ENVS=`tox -l 2> /dev/null | awk 'NR>2{ print $1 }'`
        ENVS=`tox -l 2> /dev/null`
        COMPREPLY=( $( compgen -W '$ENVS' -- "$cur" ) )
    elif [[ "$cur" == -* || -z "$cur" ]]; then
        COMPREPLY=( $( compgen -W '-h --help --version -v
                                    --hi --help-ini --showconfig
                                    -e
                                    -l --listenvs
                                    --hashseed
                                    --notest --sdistonly --develop --pre
                                    --recreate -r
                                    ' -- "$cur" ) )
    fi

}


complete -o default -F _tox_completion tox
