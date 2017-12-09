#!/usr/bin/env bash

set -e

DIR=`mktemp -d`
cd ${DIR}
pip download --no-binary all -d ${DIR} $@
devpi upload --index sax/cache --from-dir ${DIR}
cd -
rm -fr ${DIR}


