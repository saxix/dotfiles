#!/bin/sh

_fabric()
{
    local cur prev split=false

	COMPREPLY=()
	cur=`_get_cword`
	prev=${COMP_WORDS[COMP_CWORD-1]}
	_split_longopt && split=true

	case "$prev" in
        (-f|-fabfile)
            _filedir
            return 0
            ;;
    esac

    $split && return 0

    if [[ "$cur" == -* ]]; then
                COMPREPLY=( $( compgen -W '-h --help -V --version -l --list -d \
                --display= -r --reject-unknown-hosts -D --disable-known-hosts \
                -u --user= -p --password= -H --hosts= -R --roles= -i -f --fabfile= \
                -w --warn-only -s --shell= -c --config= --hide= --show=' \
                            -- "$cur" ) )
    else
                CUSTOM_TASKS=`fab -l 2> /dev/null | awk 'NR>2{ print $1 }'`
                COMPREPLY=( $( compgen -W '$CUSTOM_TASKS' -- "$cur" ) )
    fi
} 

complete -F _fabric fab

_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                COMP_CWORD=$COMP_CWORD \
                PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip

