#!/bin/bash

. ~/.bash/.colors.sh

for dir in `find . -maxdepth 1 -type d`; do
	pushd "${dir}" > /dev/null
	if [ -d "$PWD/.git" ]; then
		success "Current dir: ${PWD}"
		git fetch --all -q || exit 1
		git gc --prune=now -q > /dev/null || exit 1
		git remote prune origin > /dev/null || exit 1
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
			git pull -q > /dev/null || exit 1
			#fi
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
