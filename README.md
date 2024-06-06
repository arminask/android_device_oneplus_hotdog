# TWRP device tree for OnePlus 7T Pro (hotdog)

## Disclaimer - Unofficial TWRP!

These are personal test builds of mine. In no way do I hold responsibility if it/you messes up your device.
Proceed at your own risk.

## Compile

Setup repo tool from here https://source.android.com/setup/develop#installing-repo
Initialize and sync minimal manifest for TWRP: https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp
To build, execute these commands in order

```
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
lunch twrp_hotdog-eng
mka adbd recoveryimage
```

To test it:

```
# To temporarily boot it
fastboot boot out/target/product/hotdog/recovery.img 

# Since 7T / Pro has a dedicated recovery partition, you can flash the recovery with
fastboot flash recovery recovery.img
```

## Features

### Tested / Working

- [X] Flashing ROMs (custom OS's)
- [X] all important partitions listed in mount/backup lists
- [X] MTP export
- [X] ADB: sideload, push/pull, logcat, shell
- [X] FBEv1: decrypt /data - Only working for Custom OS's (not tested on STOCK)
- [X] FBEv1: decrypt /data/media (internal storage)
- [X] Backup/Restore to/from internal storage

### Untested
- F2FS support
- backup/restore to/from external (USB-OTG) storage
- backup/restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)

## NOT WORKING

- FastbootD doesn't show up on PC

## Credits

- AXP-OS / steadfasterX for modifying TWRP tree
- CaptainThrowback for original trees.
- mauronofrio for original trees.
- TWRP team and everyone involved for their amazing work.
- SystemAD for the further development on these trees

