#!/bin/bash

# Mount Windows partition if it exists
echo "Checking for Windows partition"
if [ -b /dev/block/by-name/win ]; then
  echo "Mounting Windows partition"
  mkdir -p /win
  mount.ntfs /dev/block/by-name/win /win

  # Check if mount was successful
  if mountpoint -q /win; then
    echo "Windows partition mounted sucessfully"

    # Search for qcremotefs directory
    SEARCH_DIR="/win/Windows/System32/DriverStore/FileRepository/"

    # Find the directory that starts with "qcremotefs" in the specified directory
    DIR_NAME=$(find "$SEARCH_DIR" -type d -name "qcremotefs*" | head -n 1)

    if [ -n "$DIR_NAME" ]; then
      echo "Found Windows modem directory: $DIR_NAME"

      # Dump modem
      echo "Flashing modemst1 and modemst2"
      dd if=/dev/block/by-name/modemst1 of="$DIR_NAME/bootmodem_fs1"
      dd if=/dev/block/by-name/modemst2 of="$DIR_NAME/bootmodem_fs2"
      echo "Modem successfully flashed"
    else
      echo "qcremotefs directory not found. Skipping modem dump."
    fi

    # Unmount Windows
    umount /win
  else
    echo "Failed to mount Windows partition. Exiting."
  fi
else
  echo "Windows partition not found. Exiting."
fi

echo "Modem sucessfully dumped."
