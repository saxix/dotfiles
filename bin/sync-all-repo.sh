#!/bin/bash

for dir in `find . -maxdepth 1 -type d`; do
	pushd "${dir}" > /dev/null
	if [ -d "$PWD/.git" ]; then
		echo "Current dir: ${PWD}"
		git fetch --all
		git gc --prune=now
		git remote prune origin
		#git branch --merged | grep -v "\*" | xargs -n 1 git branch -d  # delete merged branches
		git branch -a
		for i in $(git branch | sed 's/^.//'); do
			git checkout $i || exit 1
			git pull && git push
		done
		git co develop # back to develop
		#git pull --all || exit 1>
		#git push --all  || exit 1
		#git push --tags  || exit 1
		echo "================================================================================================================================"
	fi
	popd > /dev/null
done

