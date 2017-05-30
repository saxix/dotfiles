#!/bin/bash
TARGET=/data/PROGETTI

df -h ${TARGET}
#sudo find ${TARGET}/ -name *.pyc -o -name '~build' -exec du -d0 -h "{}" \;
find ${TARGET}/ -name *.pyc -o -name '~build' -o -name '.cache' | xargs rm -fr
find ${WORKON_HOME}/ -name *.pyc | xargs rm -f


df -h ${TARGET}
