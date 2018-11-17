#!/usr/bin/env bash
# Requires 'jq': https://stedolan.github.io/jq/
set -e
help (){
    echo "./docker-remove <image>"
    echo " "
    echo "  -u,--username USERNAME "
    echo "  -p,--password PASSWORD "
    echo "  -o,--organization ORGANIZATION "
    echo "  -t,--tag TAG "
    echo "  -l,--list"
    echo "  -n,--no-input"
}

list_images(){
    REPO_LIST=$(curl -s -H "Authorization: JWT ${TOKEN}" $CURL_BASE_URL/?page_size=200 | jq -r '.results|.[]|.name')
    echo ${REPO_LIST} | tr " " "\n" | sort -g
    exit 0
}

list_tags(){
    IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" $CURL_BASE_URL/${IMAGE}/tags/?page_size=300 | jq -r '.results|.[]|.name')
    for j in ${IMAGE_TAGS}; do
        echo "  - ${j}"
    done
}

process_tag(){
    TAG=$1
    echo -e "\n\e[31mWARNING!! THIS OPERATION CANNOT BE REVERTED\e[0m"
    echo -e "\e[31mPermantly removing \e[37m$ORGANIZATION/$IMAGE:$TAG\e[0m"
    echo -e "\e[31mAre you sure?\e[0m"
    read confirm
    if [ $confirm == "y" ];then
        curl -X DELETE -s -H "Authorization: JWT ${TOKEN}" ${CURL_BASE_URL}/${IMAGE}/tags/${TAG}/ | jq -r '.detail'
    else
        echo "Image not deleted"
    fi
}

process_image(){
    IMAGE=$1
    echo "Listing tags of $ORGANIZATION/$IMAGE"
    IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" $CURL_BASE_URL/${IMAGE}/tags/?page_size=300 | jq -r '.results|.[]|.name')
    IMAGE_TAGS=`echo ${IMAGE_TAGS} | tr " " "\n" | sort -g`
    for j in ${IMAGE_TAGS}; do
        while read -n1 -r -p "Removing ${j} [y]es | [n]o | e[x]it  " && [[ $REPLY != q ]]; do
          case $REPLY in
            y)  process_tag $j
                break ;;
            n)  echo""; break ;;
            x)  echo""; break ;;
            *)  echo "Plase choose [y]es | [n]o | e[x]it  ";;
          esac
        done;
        if [ $REPLY == "x" ];then
            exit 1
        fi
    done
}

USERNAME=$DOCKER_USER
ORGANIZATION=$DOCKER_USER
PASSWORD=$DOCKER_PASS
TAG=
LIST=0
SCAN=0
INTERACTIVE=1
IMAGE=

while [ "$1" != "" ]; do
case $1 in
    -u|--username)
        USERNAME="$2"
        shift
        shift
        ;;
    -p|--password)
        PASSWORD="$2"
        shift
        shift
        ;;
    -o|--organization)
        ORGANIZATION="$2"
        shift
        shift
        ;;
    -t|--tag)
        TAG="$2"
        shift
        shift
        ;;
    -n|--no-input)
        INTERACTIVE=0
        shift
        ;;
    -s|--scan)
        SCAN=1
        shift
        ;;
    -l|--list)
        LIST=1
        shift
        ;;
    -h|--help)
        help
        ;;
    *)  if [ -z "$IMAGE" ];then
            IMAGE=$1
            shift
        else
            echo "unknown option '$1'"
            help
            exit 1
        fi
       ;;
esac
done
if [ "$IMAGE" == "" -o "$USERNAME" == "" -o "$PASSWORD" == "" ];then
  help
fi
#shift

TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${USERNAME}'", "password": "'${PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

CURL_BASE_URL="https://hub.docker.com/v2/repositories/${ORGANIZATION}"

if [ $SCAN -eq 1 ];then
    list_images
elif [ $LIST -eq 1 ];then
    list_tags
elif [ -z "$TAG" ];then
    #    multiple tags always has INTERACTIVE=true
    INTERACTIVE=1
    process_image $IMAGE
else
    process_tag $TAG
fi
