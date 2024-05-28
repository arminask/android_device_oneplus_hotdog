#!/bin/bash

# Mount Windows
echo "Mounting Windows partition"
mkdir /win
mount.ntfs /dev/block/by-name/win /win

# Search for qcremotefs directory
SEARCH_DIR="/win/Windows/System32/DriverStore/FileRepository/"

# Find the directory that starts with "qcremotefs" in the specified directory
DIR_NAME=$(find "$SEARCH_DIR" -type d -name "qcremotefs*" | head -n 1)

# Print the found directory name
echo "Found Windows modem directory: $DIR_NAME"

# Dump modem
echo "Flashing modemst1 and modemst2"
dd if=/dev/block/by-name/modemst1 of=$DIR_NAME/bootmodem_fs1
dd if=/dev/block/by-name/modemst2 of=$DIR_NAME/bootmodem_fs2
echo "Modem succesfully flashed"

# Unmount Windows
umount /win

echo "Modem dumped!"
