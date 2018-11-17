

_cdd_completion()
{
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`

	APPS=`cd "$PROJECT_DIR"; for f in *; do echo $f; done | command \sort`
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

_cdu_completion()
{
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`

	APPS=`cd "/data/PROGETTI/UNICEF/"; for f in *; do echo $f; done | command \sort`
    COMPREPLY=( $( compgen -W '$APPS' -- "$cur" ) )
}
complete -o default -F _cdu_completion cdu

function cdu {
	if [ $1 ] ;then
		cd "/data/PROGETTI/UNICEF/$1/"
	fi
}

function cdw {
	if [ $1 ] ;then
		cd "/data/PROGETTI/ONU_WorldFoodProgramme/$1/"
	fi
}

function cdd {
	if [ $1 ] ;then
		cd "$PROJECT_DIR/$1/"
	fi
}


function ad {
	if [ "$1" == "install" ];then
		echo "Install $2"
		pushd $DJANGO_DIR || exit 1
		dest=`echo "${2%.*}.x"`
		echo rm -fr "Django-$2" "$dest" "Django-${2%.*}.*"
		rm -fr Django-$2 $dest "Django-${2%.*}.*"
		find . -name "Django-${2%.*}.*" -d 1 | xargs rm -fr
		wget https://www.djangoproject.com/download/$2/tarball/ -O Django-$dest.tar.gz
		tar --overwrite -xzf Django-$dest.tar.gz
		ln -fs "Django-$2" "$dest"
		rm -f Django-$dest.tar.gz
		popd > /dev/null
  elif [ -e "$DJANGO_DIR/$1/django" ];then
		pip uninstall -y django
		pip install --pre -e "$DJANGO_DIR/$1"
	fi
}

_ad_completion()
{
	prev=${COMP_WORDS[COMP_CWORD-1]}
	cur=`_get_cword`

	DJANGOS=`cd "$DJANGO_DIR"; for f in *.x/django; do echo $f; done | command \sed "s|/django||" | command \sort`
    DJANGOS="$DJANGOS trunk install"
    COMPREPLY=( $( compgen -W '$DJANGOS' -- "$cur" ) )
}
complete -o default -F _ad_completion ad
