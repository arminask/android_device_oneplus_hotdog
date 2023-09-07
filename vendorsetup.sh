# DIRTY WORKAROUND to get FBEv2 working on hotdog
TFILE=$OUT/fscrypt.patched
[ ! -d "$OUT" ]&& mkdir -p $OUT
RET=0

if [ -f "$TFILE" ];then
    echo "fscrypt patched already, skipping"
else
    cd system/extras
    git apply ../../device/oneplus/hotdog/patches/0001-fscrypt-bypass-FS_IOC_-G-S-ET_ENCRYPTION_POLICY.patch || RET=$?
    if [ $RET -ne 0 ];then
	echo "FATAL: fscrypt.cpp could not be patched!! Decryption in TWRP will FAIL."
	exit $RET
    else
	echo "OK: fscrypt.cpp patched"
	touch $TFILE
    fi
fi
