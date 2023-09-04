# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

LOCAL_PATH := device/oneplus/hotdog

# define hardware platform
PRODUCT_PLATFORM := msmnile

# A/B support
AB_OTA_UPDATER := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
	boot \
	system \
	system_ext \
	vendor \
	vbmeta \
	dtbo

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
#TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-impl-wrapper.recovery \
    android.hardware.boot@1.0-impl-wrapper \
    android.hardware.boot@1.0-impl.recovery \
    bootctrl.$(PRODUCT_PLATFORM) \
    bootctrl.$(PRODUCT_PLATFORM).recovery \

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd \
    resetprop

# qcom decryption
PRODUCT_PACKAGES_ENG += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# tzdata
PRODUCT_PACKAGES_ENG += \
    tzdata_twrp

# Apex libraries
#PRODUCT_COPY_FILES += \
#    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(LOCAL_PATH)/security/oneplus \
    $(LOCAL_PATH)/security/pixelexperience \

PRODUCT_BUILD_RECOVERY_IMAGE := true

# Crypto (forces FBE v2 regardless of PRODUCT_SHIPPING_API_LEVEL)
# ensure you remove CONFIG_DM_CRYPT=y from your kernel config or set ro.crypto.allow_encrypt_override=true
# https://source.android.com/docs/security/features/encryption/file-based
# https://source.android.com/docs/security/features/encryption/metadata
PRODUCT_PROPERTY_OVERRIDES += \
        ro.crypto.volume.filenames_mode=aes-256-cts \
        ro.crypto.volume.metadata.method=dm-default-key \
        ro.crypto.dm_default_key.options_format.version=2

# adoptable storage:
# https://source.android.com/docs/security/features/encryption/file-based#enabling-fbe-on-adoptable-storage
PRODUCT_PROPERTY_OVERRIDES += \
        ro.crypto.volume.options=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized \
        ro.crypto.volume.contents_mode=aes-256-xts \
        ro.crypto.volume.filenames_mode=aes-256-cts
