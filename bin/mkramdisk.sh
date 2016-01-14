#!/usr/bin/env bash
ramfs_size_mb=2100

mkramdisk() {
  ramfs_size_sectors=$((${ramfs_size_mb}*1024*1024/512)) || exit 1
  ramdisk_dev=`hdid -nomount ram://${ramfs_size_sectors}`  || exit 1

  newfs_hfs -v 'ram disk' ${ramdisk_dev} || exit 1
  mkdir -p ${1} || exit 1
  mount -o noatime -t hfs ${ramdisk_dev} ${1} || exit 1

  echo "remove with:"
  echo "umount ${1}"
  echo "diskutil eject ${ramdisk_dev}"
  echo "rmdir ${1}"
}

mount_point=${1-/tmp/rdisk}

if [ -e ${mount_point} ]; then
    echo ${mount_point} already exists
else
    mkramdisk "${mount_point}"
fi
