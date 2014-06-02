
CC_DIR="${HOME}/.cookiecutters"

_cookiecutters_completion()
{
#	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`
#    echo 1, $cur
#    echo 2, $prev

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-h --help -V --version -v --verbose --no-input -c' -- "$cur" ) )
    elif [[ -z "$cur" ]];then
         APPS=`cd "$CC_DIR"; for f in *; do echo "$f"; done | command \sort`
        COMPREPLY=( $( compgen -W '$APPS' -- "$cur" ) )
    fi

}


complete -o filenames -F _cookiecutters_completion cookiecutter

