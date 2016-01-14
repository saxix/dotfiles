#!/bin/bash

for dir in `find . -maxdepth 1 -type d`; do
	pushd "${dir}" > /dev/null
	if [ -d "$PWD/.git" ]; then
		echo "Current dir: ${PWD}"
        git checkout master
        devpi install
		git co develop # back to develop
		echo "================================================================================================================================"
	fi
	popd > /dev/null
done
