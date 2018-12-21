#!/bin/bash

IMG_FILE=/path/to/encrypted/file/container
DM_NAME=my_dm_mapper_name
MOUNT_PATH=/path/to/my/mount

cryptsetup luksOpen $IMG_FILE $DM_NAME
mount /dev/mapper/$DM_NAME $MOUNT_PATH
