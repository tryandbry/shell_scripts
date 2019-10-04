#!/bin/bash

# find and remove old files and directories

find $HOME/Downloads -atime +30 -delete
find $HOME/Downloads -type d -empty -delete
find $HOME/tmp -atime +30 -delete
find $HOME/tmp -type d -empty -delete
