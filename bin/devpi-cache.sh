#!/usr/bin/env bash

help (){
    echo "./devpi-cache.sh"
    echo " "
    echo "  -r,--requirements FILENAME    pip requirements"
    echo "  -f,--pipfile                  use pipfile"
    echo "  -p,--package PACKAGE          package name"
    echo "  -u,--url URL                  url to PACKAGE"
    echo "  -d,--dir DIR                  working directory"
    echo "  -h,--help                     This help screen"
    exit 1
}

set -e
REQUIREMENTS=
PIPFILE=
PACKAGE=
URL=
DIR=
while [ "$1" != "" ]; do
case $1 in
  -d|--dir)
		  shift
			DIR="$1"
			shift # past argument
			;;
	-r|--requirements)
		  shift
			REQUIREMENTS="$1"
			shift # past argument
			;;
	-f|--pipfile)
		PIPFILE="1"
		shift # past argument
		;;
	-p|--package)
		shift
		PACKAGE="$1"
		shift # past argument
		;;
  -u|--url)
		  shift
			URL="$1"
			shift # past argument
			;;
	*) echo "unknown option '$1'"
		 help
		 ;;
esac
done
if [ -z "${REQUIREMENTS}${PIPFILE}${PACKAGE}${URL}" ]; then
	help
fi

if [ -z "${DIR}" ];then
  DIR=`mktemp -d`
else
  mkdir -p $DIR
fi

echo "Working dir: ${DIR}"
echo "PIPFILE: ${PIPFILE}"
echo "URL: ${URL}"

if [ -n "$URL" ]; then
  pip download --no-binary all -d ${DIR} $URL
fi

if [ -n "$PIPFILE" ]; then
  REQUIREMENTS=${DIR}/requirements.txt
	pipenv lock -r > ${REQUIREMENTS}
  echo "Create requirements file ${REQUIREMENTS}"
fi
cd ${DIR}
if [ -n "$REQUIREMENTS" ]; then
  echo "Using requirements file ${REQUIREMENTS}"
	pip download --no-binary all -d ${DIR} -r $REQUIREMENTS
	devpi upload --index sax/cache --from-dir ${DIR}
else
  echo "Downloading package ${PACKAGE}"
	pip download --no-binary all -d ${DIR} $PACKAGE
	devpi upload --index sax/cache --from-dir ${DIR}
fi

rm -fr ${DIR}
