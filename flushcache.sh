#!/bin/bash
  source inc/systemconf.sh
  source config.sh

  # Specify dependencies
  declare -a depends=("hdparm")

  echo "Minetest Server Admin for Linux"
  echo "By Robbie Ferguson - https://minetest.tv"
  echo "----------------------------------------"
  echo "Disk Cache Safe Flush Utility $ver"
  echo ""

  MTDISK=$1
  me=`basename "$0"`
  if [ -z "$MTDISK" ]; then
    echo "Usage: ./$me DISK"
    echo "Example: ./$me /dev/sda"
    exit 1
  else
    if grep $MTDISK /etc/mtab > /dev/null 2>&1; then
      echo "$MTDISK found."
    else
      echo "$MTDISK is not a valid device."
      exit 1
    fi
  fi

if [[ $EUID -ne 0 ]]; then
  echo "ERROR: You must be a root" 2>&1
  exit 1
else
  source ./inc/check-depends.sh
  
  echo Flushing buffers to disk...

  # (move data, modified through FS -> HDD cache) + flush HDD cache
  sync

  # (slab + pagecache) -> HDD (https://www.kernel.org/doc/Documentation/sysctl/vm.txt)
  echo 3 > /proc/sys/vm/drop_caches

  blockdev --flushbufs $MTDISK

  hdparm -F $MTDISK

  # Sync again since we've now written the changes
  sync

  echo 'Done.'
fi
