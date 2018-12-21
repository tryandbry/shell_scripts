#!/bin/bash

DM_NAME=my_dm_mapper_name
MOUNT_PATH=/path/to/my/mount

umount $MOUNT_PATH
cryptsetup luksClose /dev/mapper/$DM_NAME
