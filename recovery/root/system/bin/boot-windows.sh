#!/bin/bash

# Flash OOS11 devcfg
echo "Flashing OOS11 devcfg"
dd if=/directory/devcfg_oos11.img of=/dev/block/by-name/devcfg_a
dd if=/directory/devcfg_oos11.img of=/dev/block/by-name/devcfg_b
echo "devcfg succesfully flashed"

# Flash UEFI
echo "Flashing UEFI"
dd if=/directory/UEFI.img of=/dev/block/by-name/boot_a
dd if=/directory/UEFI.img of=/dev/block/by-name/boot_b
echo "UEFI succesfully flashed"

echo "Rebooting to Windows..."
reboot system
