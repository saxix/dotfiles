#!/bin/bash

. $HOME/.bash/.colors.sh

CLEAN=0
DIRS=()
FETCH=0
IGNORE=()
ONLY=()
PATTERN=""
PUSH=0
RESET=0
STASH=0
SUBMODULES=0
TARGET=""
TRAVERSE=0
VERBOSE=1
_PROMPT=0

GIT=/usr/bin/git

function log () {
    if [[ $VERBOSE -gt $1 ]]; then
        echo "$2"
    fi
}

function _warn () {
    if [[ $VERBOSE -gt $1 ]]; then
        warn "$2"
    fi
}

function _success () {
    if [[ $VERBOSE -gt $1 ]]; then
        success "$2"
    fi
}

function help() {
    echo "sync-all-repo"
    echo Syncronize all git repository in the current directory
    echo
    echo "     -d/--directory      target directory [default $PWD]"

    echo "     -c/--clean          prune/garbage and remove merged local branches"
    echo "     -f/--fetch          fetch all remotes"
    echo "     -i/--ignore DIR     ignore DIR"
    echo "     -m/--match PATTERN  directory match"
    echo "     -o/--only DIR       only DIR"
    echo "     -p/--prompt         prompt for action if changes"
    echo "     -q/--quiet          quiet"
    echo "     -r/--reset          always run 'git reset --hard' before pull"
    echo "     -s/--stash          stash changes before pull"
    echo "     -t/--traverse       traverse target directory"

    echo "     -v/--verbosity      verbosity"
    echo "     --push              push to remote"
}

while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
      --stash)
        STASH=1
        ;;
      --reset)
        RESET=1
        ;;
      -p|--prompt)
        _PROMPT=1
        ;;
      -c|--clean)
  		  CLEAN=0
  			;;
      -f|--fetch)
  		  FETCH=0
  			;;
			-q|--quiet)
				VERBOSE=0
				;;
			-v|--verbose)
			  VERBOSE=$2
				shift
				;;
      -t|--traverse)
  				TRAVERSE=1
  				;;
			-i|--ignore)
				IGNORE+=("$2")
				shift
				;;
			-o|--only)
				ONLY+=("$2")
				shift
				;;
	    -d|--directory)
				DIRS+=("$2")
		    shift # past argument
		    ;;
	    -m|--match)
		    PATTERN="$2"
		    shift # past argument
				;;
			--push)
			  PUSH=1
				;;
			--sub)
				SUBMODULES=1
			  ;;
			-h|--help)
          help;
          exit 1;
					;;
	    *)
				error "unknown option '$key'"
				help;
        exit 1
	      ;;
	esac
	shift # past argument or value
done
if [ -z "$VERBOSE" ]; then
  error "Invalid -v/--verbose value. [1-3]"
  help
  exit 1
fi

if [ ${#DIRS[@]} -eq 0 ];then
	DIRS=($PWD)
fi

if [ $TRAVERSE -gt 0 ];then
  REPOSITORIES=`find $DIRS -name .git -type d -prune -exec dirname {} \;`
else
  #REPOSITORIES="${DIRS[@]}"
  REPOSITORIES=`find $DIRS -name .git -maxdepth 2  -type d -prune -exec dirname {} \;`
fi

for dir in $REPOSITORIES; do
#  warn "Skip $TARGET"
#  continue
#	for dir in `find ${TARGET} -maxdepth 1 -type d -not -name ".*"`; do
		#if [[ "$dir" != "./${PATTERN}"* ]]; then
		#warn "Skip $dir"
		#continue
		#fi
		name=$(basename "$dir")
		if [[ " ${IGNORE[@]} " =~ " ${name} " ]]; then
			log 1 "Skip $dir"
			continue
		fi
		if [[ -n "${ONLY[@]}" ]]; then
	  	if ! [[ " ${ONLY[@]} " =~ " ${name} " ]]; then
				log 1 "Skip $dir"
				continue
			fi
		fi
		pushd "${dir}" > /dev/null
		if [ -z "$(${GIT} remote 2> /dev/null)" ]; then
			log 1 "Skip $dir: No remotes"
			#popd > /dev/null
		elif [ -d "$PWD/.git" ]; then
			success "Current dir: ${PWD}"
      if [ $FETCH -eq 1 ];then
			   ${GIT} fetch --all -q > /dev/null || exit 1
      fi
      if [ $CLEAN -eq 1 ];then
			     ${GIT} gc --prune=now -q > /dev/null || exit 1
			        ${GIT} remote prune origin > /dev/null || (popd ; continue)
			           ${GIT} branch --merged | grep -v "\*" | xargs -n 1 ${GIT} branch -d  # delete merged branches
      fi
      if [ $VERBOSE -gt 1 ];then
        ${GIT} branch -l
      fi
			current=$(${GIT} st | awk '/On branch /{print $3}')
      branches=$(/usr/bin/git branch --no-color -l | sed 's/^.//')
			_warn 1 "Local branches `${GIT} branch -l|wc -l` branches"
			_warn 1 "Current branch $current"
      #echo 111, `/usr/bin/git branch --no-color -l`, 22222
			#for i in $(${GIT} branch | sed 's/^.//' >/dev/null); do
      for i in ${branches}; do
				detached=$(echo $i| cut -d' ' -f 2)
				#if [ -n "$detached" ];then
				_warn 1 "   >>> Syncing: $i"
				output=$(${GIT} checkout $i > /dev/null 2>&1)
        if [[ $? -ne 0 ]];then
          echo ${output}
          exit 1
        fi

        if [ $RESET -eq 1 -o $_PROMPT -eq 1 -o $STASH -eq 1 ];then
          if [ -n "`${GIT} diff`" ]; then
            if [ $VERBOSE -gt 0 ];then
              _warn 1 "WARNING: unstaged changes detected"
            fi
            if [ $_PROMPT -eq 1 ];then
              echo -n "reset this repo [y/N]?"
              read -n 1 CONFIRM
              if [ $CONFIRM != "y" ];then
                continue
              fi
            fi
					  ${GIT} reset --hard > /dev/null || exit 1
            _warn 1 "WARNING: $i branch has been hard reset"
          fi
				fi

				if [ $SUBMODULES -eq 1 ];then
					output=$(${GIT} pull $Q --recurse-submodules > /dev/null) || exit $?
				else
          output=$(${GIT} pull) || exit $?
        fi
        if [[ ${output} =~ "is up to date." ]]; then
          _success 1 "   >>> ${output}"
        else
          if [ ${VERBOSE} -gt 1 ];then
            ${GIT} log -n 3
          fi
				fi

				if [ $PUSH -gt 0 ];then
					${GIT} push --all
					${GIT} push --tags
				fi
			done
			if [ -n "$current" ];then
				_warn 1 "Back to $current branch"
				${GIT} checkout $current -q > /dev/null 2>&1 # back to develop
			fi
			#${GIT} pull --all || exit 1>
			#${GIT} push --all  || exit 1
			#${GIT} push --tags  || exit 1
      if [ $VERBOSE -gt 1 ];then
			     echo "=========================================="
           echo
           echo
      fi
		fi
    popd > /dev/null
#	done
done
