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
		warn "Local branches `git branch -l|wc -l` branches"
		for i in $(git branch | sed 's/^.//'); do
			warn "   >>> Syncing: $i"
			git checkout $i -q > /dev/null || exit 1
			git pull -q > /dev/null || exit 1
		done
		git co develop -q # back to develop
		#git pull --all || exit 1>
		#git push --all  || exit 1
		#git push --tags  || exit 1
		echo "=========================================="
	fi
	popd > /dev/null
done
