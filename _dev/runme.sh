#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

set -e
echo "Working dir:" ${DIR}

cd ${DIR}

VENV=${WORKON_HOME}/saxix

. ${VENV}/bin/activate && \
    ${VENV}/bin/pip install -U pip-tools devpi-builder && \
    ${VENV}/bin/pip-compile --no-header --no-index --no-emit-trusted-host ${DIR}/requirements.in -o ${DIR}/requirements.txt && \
    ${VENV}/bin/devpi-builder requirements.txt http://localhost:3141/sax/cache --user sax


VENV=${WORKON_HOME}/3saxix

. ${VENV}/bin/activate && \
    ${VENV}/bin/pip install -U pip-tools devpi-builder && \
    ${VENV}/bin/pip-compile --no-header --no-index --no-emit-trusted-host ${DIR}/requirements3.in -o ${DIR}/requirements3.txt && \
    ${VENV}/bin/devpi-builder requirements3.txt http://localhost:3141/sax/cache --user sax

