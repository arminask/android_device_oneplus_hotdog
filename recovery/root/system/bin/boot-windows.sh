#!/bin/bash

# Check if images exist
flash_image() {
  local img_path=$1
  local partition_a=$2
  local partition_b=$3
  local image_name=$4

  if [ -f "$img_path" ]; then
    echo "Flashing $image_name"
    dd if="$img_path" of="$partition_a"
    dd if="$img_path" of="$partition_b"
    echo "$image_name successfully flashed"
  else
    echo "$img_path does not exist. Skipping $image_name."
  fi
}

# Flash OOS11 devcfg
flash_image "/sdcard/devcfg_oos11.img" "/dev/block/by-name/devcfg_a" "/dev/block/by-name/devcfg_b" "OOS11 devcfg"

# Flash UEFI
flash_image "/sdcard/UEFI.img" "/dev/block/by-name/boot_a" "/dev/block/by-name/boot_b" "UEFI"

# Reboot to Android
echo "Rebooting to Windows..."

sleep 2

reboot system
