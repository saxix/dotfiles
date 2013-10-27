
_dir_completition_factory(){

}


PROJECT_DIR="/data/PROGETTI/saxix/"
_cdd_completion()
{
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`

	APPS=`cd "$PROJECT_DIR"; for f in django-*; do echo $f; done | command \sed "s|django-||" | command \sort`
    COMPREPLY=( $( compgen -W '$APPS' -- "$cur" ) )
}
complete -o default -F _cdd_completion cdd

_cdw_completion()
{
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`

	APPS=`cd "/data/PROGETTI/ONU_WorldFoodProgramme/"; for f in *; do echo $f; done | command \sort`
    COMPREPLY=( $( compgen -W '$APPS' -- "$cur" ) )
}
complete -o default -F _cdw_completion cdw

function cdw {
	if [ $1 ] ;then
		cd "/data/PROGETTI/ONU_WorldFoodProgramme/$1/"
	fi
}

function cdd {
	if [ $1 ] ;then
		cd "$PROJECT_DIR/django-$1/"
	fi
}

DJANGO_DIR="/data/VENV/LIB/django/"
_ad_completion()
{
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`

	DJANGOS=`cd "$DJANGO_DIR"; for f in */django; do echo $f; done | command \sed "s|/django||" | command \sort`
    COMPREPLY=( $( compgen -W '$DJANGOS' -- "$cur" ) )
}
complete -o default -F _ad_completion ad
