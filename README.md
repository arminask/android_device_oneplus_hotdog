# TWRP device tree for OnePlus 7T Pro (hotdog)

TWRP with additional functionality for hotdog devices dualbooting Windows ARM. <br />
Included scripts to reboot to windows/android, dump modem in TWRP. <br />
Included additional binaries in TWRP: mass storage mode, parted. <br />
This only applies if you specifically have Oneplus 7T Pro (hotdog). <br />
**Using it for another device is very dangerous. Verify that the scripts flash to the correct partitions for your phone!** <br />
<br />
Additional partitions included in TWRP "Mount" page:
- Windows (Main Windows NTFS partition, it will only mount if you named your partition `win`).
- ESP (Windows EFI FAT32 partition, it will only mount if you named your partition `esp`). <br />
<br />
By default, these scripts look for images in the TWRP root directory: <br />
- UEFI.img is the UEFI that you're using <br />
- android-boot.img is your stock Android boot image <br />
- devcfg_oos11.img is devcfg.img extracted from your device OOS11 firmware <br />
- devcfg_oos12.img is devcfg.img extracted from your device OOS12 firmware <br />
<br />
If you want to include images to an already compiled TWRP, unpack it with Android Image Kitchen and put it in the ramdisk folder (it's the same root directory as `/system/root`). <br />
<br />
Please note that if you include these .img files inside your TWRP image, it might not boot on your device because of your recovery size. To get around this, you can put your .img files your userdata partition (userdata needs to be mounted and decrypted first!) and then change .img locations in scripts. <br />

## Script functionality
To run each script, execute these commands in the terminal: <br />
- `dump-modem` - Mounts your Windows partition and flashes modemst1/2 to Windows qcremotefs directory.
- `boot-windows` - Flashes OOS 11 devcfg.img and UEFI partition, then reboots to Windows.
- `boot-android` - Flashes OOS 12 devcfg.img and your stock Android boot image, then reboots to Android.
- `msc` - Enables mass storage mode on your phone.
- `parted` - Binary for partition editing.
<br />
## Disclaimer - Unofficial TWRP!

These are personal test builds of mine. In no way do I hold responsibility if it/you messes up your device.
Proceed at your own risk.

## Compile

Setup repo tool from here https://source.android.com/setup/develop#installing-repo

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

### Untested

- Backup to internal/microSD
- Restore from internal/microSD
- F2FS support
- backup/restore to/from external (USB-OTG) storage
- backup/restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)

## NOT WORKING

- FastbootD doesn't show up on PC

## Credits

- CaptainThrowback for original trees.
- mauronofrio for original trees.
- TWRP team and everyone involved for their amazing work.
- SystemAD for the further development on these trees

