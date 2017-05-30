#!/bin/bash

. $HOME/.bash/.colors.sh
TARGET=""
PATTERN=""
PUSH=0
IGNORE=()
ONLY=()
VERBOSE=1
SUBMODULES=0
DIRS=()

function log () {
    if [[ $VERBOSE -gt $1 ]]; then
        echo "$2"
    fi
}

while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
			-q|--quiet)
				VERBOSE=0
				shift
				;;
			-v|--verbose)
			  VERBOSE=$2
				shift
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
					echo "sync-all-repo"
					echo Syncronize all git repository in the current directory
					echo
					echo "-d/--directory      target directory [default $PWD]"
					echo "-m/--match PATTERN  directory match"
					echo "-i/--ignore DIR     ignore DIR"
					echo "-o/--only DIR       only DIR"
					echo "-v/--verbosity      verbosity"
					echo "-q/--quiet          quiet"
					echo "--push              push to remote"
			    exit 1
					;;
	    *)
				echo "unknown option '$key'"
				exit 1
	      ;;
	esac
	shift # past argument or value
done
if [ ${#DIRS[@]} -eq 0 ];then
	DIRS=($PWD)
fi

for TARGET in "${DIRS[@]}";do
	for dir in `find ${TARGET} -maxdepth 1 -type d -not -name ".*"`; do
		#if [[ "$dir" != "./${PATTERN}"* ]]; then
		#	warn "Skip $dir"
		#	continue
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
		if [ -z "$(git remote 2> /dev/null)" ]; then
			log 1 "Skip $dir: No remotes"
			#popd > /dev/null
		elif [ -d "$PWD/.git" ]; then
			success "Current dir: ${PWD}"
			git fetch --all -q || exit 1
			git gc --prune=now -q > /dev/null || exit 1
			git remote prune origin > /dev/null || (popd ; continue)
			#git branch --merged | grep -v "\*" | xargs -n 1 git branch -d  # delete merged branches
			git branch -l
			current=$(git st | awk '/On branch develop/{print $3}')
			warn "Local branches `git branch -l|wc -l` branches"
			warn "Current branch $current"
			for i in $(git branch | sed 's/^.//'); do
				detached=$(echo $i| cut -d' ' -f 2)
				#if [ -n "$detached" ];then
				warn "   >>> Syncing: $i"
				git checkout $i -q > /dev/null || exit 1
				if [ $SUBMODULES -eq 1 ];then
					git pull -q --recurse-submodules > /dev/null || exit 1
				else
					git pull -q > /dev/null || exit 1
				fi
				if [ $PUSH -gt 0 ];then
					git push --all
					git push --tags
				fi
			done
			if [ -n "$current" ];then
				warn "Checkout $current"
				git checkout $current -q # back to develop
			fi
			#git pull --all || exit 1>
			#git push --all  || exit 1
			#git push --tags  || exit 1
			echo "=========================================="
		fi
		popd > /dev/null
	done
done
