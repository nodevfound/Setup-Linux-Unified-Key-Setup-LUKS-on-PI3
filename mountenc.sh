#!/bin/bash

PARTITION_NAME="encdata"
DISK="/dev/sda1"
MOUNT_PT="/mnt/data"

OPTION=$1

if [ "$OPTION" == "mount" ]; then
	echo "[Mounting Drive]"
	cryptsetup luksOpen $DISK $PARTITION_NAME
	mount /dev/mapper/$PARTITION_NAME $MOUNT_PT
	echo "[Done]"
elif [ "$OPTION" == "unmount" ]; then
	echo "[Unounting Drive]"
	umount $MOUNT_PT
	cryptsetup luksClose /dev/mapper/$PARTITION_NAME
        echo "[Done]"
else
	echo "Mount Drive: mountenc.sh mount"
	echo "Unmount Drive: mountenc.sh unmount"
fi
