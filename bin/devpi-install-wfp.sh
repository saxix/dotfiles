#!/bin/bash
. ~/.bash/.bash_aliases.sh || exit 1
cd /data/PROGETTI/ONU_WorldFoodProgramme
LIBS='wfp-workflow wfp-timezonefield wfp-openid-client wfp-ldap wfp-geo wfp-djangosecurity wfp-djangolib wfp-django-fields wfp-crashlog wfp-commonlib wfp-capi-notifier wfp-bitfield wfp-auth wfp-andy wfp-activedirectory capi-django-loader'
# for dir in `find . -maxdepth 1 -type d`; do
for dir in $LIBS; do
	pushd "${dir}" > /dev/null || exit 1
	if [ -d "$PWD/.git" ]; then
		echo "Current dir: ${PWD}"
		git fetch  -q --all
        git checkout master -q || exit 1
		git pull -q || exit 1
        /data/VENV/sax/bin/devpi upload
		git co develop -q # back to develop
		echo "================================================================================================================================"
	fi
	popd > /dev/null
done
