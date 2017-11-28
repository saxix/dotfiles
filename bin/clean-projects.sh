#!/bin/bash
TARGET=/data/PROGETTI

du -sh ${TARGET}
find ${TARGET}/ -name '~build' -o -name '.cache' -o -name '.tox' -o -name '__pycache__' | xargs rm -fr
find ${TARGET}/ -name *.pyc | xargs rm -fr

find ${TARGET}/ONU_WorldFoodProgramme -name 'node_modules' -o -name 'dist' | xargs rm -fr
du -sh ${TARGET}
find ${WORKON_HOME}/ -name *.pyc | xargs rm -f
