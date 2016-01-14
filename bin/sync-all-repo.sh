#!/bin/bash

. ~/.bash/.colors.sh

for dir in `find . -maxdepth 1 -type d`; do
	pushd "${dir}" > /dev/null
	if [ -d "$PWD/.git" ]; then
		success "Current dir: ${PWD}"
		git fetch --all > /dev/null || exit 1
		git gc --prune=now > /dev/null || exit 1
		git remote prune origin > /dev/null || exit 1
		#git branch --merged | grep -v "\*" | xargs -n 1 git branch -d  # delete merged branches
		git branch -a
		for i in $(git branch | sed 's/^.//'); do
			warn "   >>> $i"
			git checkout $i > /dev/null || exit 1
			git pull > /dev/null || exit 1
			git push > /dev/null || exit 1
		done
		git co develop # back to develop
		#git pull --all || exit 1>
		#git push --all  || exit 1
		#git push --tags  || exit 1
		echo "=========================================="
	fi
	popd > /dev/null
done
