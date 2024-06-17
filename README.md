# TWRP device tree for OnePlus 7T Pro (hotdog)

TWRP with additional functionality for hotdog devices dualbooting Windows ARM. <br />
Included additional binaries in TWRP: mass storage mode, parted. <br />
This only applies if you specifically have Oneplus 7T Pro (hotdog). <br />

> [!CAUTION]
> Using it for another device is very dangerous. Verify that the scripts flash to the correct partitions for your phone!
> 
> Also keep in mind that these scripts don't have any safety checks, so if you don't have images in the correct paths or partitions, script will still execute and possibly brick your device. 

#### Additional partitions included in TWRP Mount page:
- Windows (Main Windows NTFS partition, it will only mount if your partition name is `win`).
- ESP (Windows EFI FAT32 partition, it will only mount if your partition name is `esp`). <br />


#### These scripts look for images in the TWRP `/sdcard/` (this is your mounted Android internal storage) directory:
- UEFI.img is the UEFI that you're using <br />
- android-boot.img is your stock Android boot image <br />
- devcfg_oos11.img is devcfg.img extracted from your device OOS11 firmware <br />
- devcfg_oos12.img is devcfg.img extracted from your device OOS12 firmware <br />


## Script functionality
<sub>WoA Tools page is a bit broken, once you enter the page, you cannot go back</sub>
<br>
<img src="https://i.imgur.com/XJUDQHo.jpeg" align="left" height="780" width="360" >
<img src="https://i.imgur.com/JQ05HFj.jpeg" align="center" height="780" width="360" >


Each button executes the corresponding scripts: <br />
- `dump-modem` - Mounts your Windows partition and flashes modemst1/2 to Windows qcremotefs directory.
- `boot-windows` - Flashes OOS 11 devcfg and UEFI partition, then reboots to Windows.
- `boot-android` - Flashes OOS 12 devcfg and your stock Android boot image, then reboots to Android.
- `msc` - Enables mass storage mode on your phone.
- `parted` - Binary for partition editing. (Can only be executed in shell)


## Disclaimer - Unofficial TWRP!

These are personal test builds of mine. In no way do I hold responsibility if it/you messes up your device.
Proceed at your own risk.

## Compile

Setup repo tool from here https://source.android.com/setup/develop#installing-repo

Initialize and sync minimal manifest TWRP: https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp

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
- [X] FBEv1: decrypt /data - Only working for Custom OS's (not tested on stock OS)
- [X] FBEv1: decrypt /data/media (internal storage)
- [X] Backup/Restore to/from internal storage

### Untested
- F2FS support
- backup/restore to/from external (USB-OTG) storage
- backup/restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)

## NOT WORKING

- In FastbootD mode device doesn't show up on PC
- Battery percentage

## Credits

- AXP-OS / steadfasterX for modifying TWRP tree
- CaptainThrowback for original trees.
- mauronofrio for original trees.
- TWRP team and everyone involved for their amazing work.
- SystemAD for the further development on these trees

