#!/bin/bash

# Flash OOS12 devcfg
echo "Flashing OOS12 devcfg"
dd if=/devcfg_oos12.img of=/dev/block/by-name/devcfg_a
dd if=/devcfg_oos12.img of=/dev/block/by-name/devcfg_b
echo "devcfg succesfully flashed"

# Flash Android boot.img
echo "Flashing Android boot image"
dd if=/android-boot.img of=/dev/block/by-name/boot_a
dd if=/android-boot.img of=/dev/block/by-name/boot_b
echo "Android boot.img succesfully flashed"

echo "Rebooting to Android..."
reboot system
