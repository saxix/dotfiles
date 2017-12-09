#!/bin/bash
. ~/.bash/.bash_aliases.sh || exit 1
LIBS='capi-django-loader
django-temporary-permissions
pytest-yasew
wfp-andy
wfp-activedirectory
wfp-auth
wfp-commonlib
wfp-django-bitfield
wfp-django-comet
wfp-django-crashlog
wfp-django-ldap
wfp-django-temp-perms
wfp-django-timezone-field
wfp-djangosecurity
wfp-djangolib
wfp-geo
wfp-openid-client
wfp-oracle9i-backend
wfp-workflow
'

TARGET=/data/WFP/

devpi login sax >/dev/null
devpi use sax/dev >/dev/null

IFS=$'\n'
for app in $LIBS; do
    echo $app
	pip download $app --no-binary all --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1
done
IFS=$' '

pip download "wfp-activedirectory==0.4" --no-binary all  --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1
pip download "wfp-django-crashlog==1.7" --no-binary all --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1
pip download "wfp-django-ldap==1.0" --no-binary all --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1
pip download "wfp-oracle9i-backend==0.6" --no-binary all --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1
pip download "wfp-workflow==0.14" --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1
#pip download "wfp-django-crashlog==1.7" --no-deps -d $TARGET --index http://pypi.wfp.org/simple || exit 1


devpi upload --index sax/wfp --from-dir ${TARGET}
#rm -fr ${TARGET}
