# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file includes all definitions that apply to ALL Amazon Kindle Fire devices, and
# are also specific to otter devices
#
# Everything in this directory will become public

COMMON_FOLDER := device/amazon/omap4-common

$(call inherit-product, hardware/ti/omap4/omap4.mk)
$(call inherit-product, hardware/ti/omap4/pvr-km.mk)

# set to allow building from omap4-common
BOARD_VENDOR := amazon

ifneq (ev_soho, $(TARGET_PRODUCT))
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := $(DEVICE_FOLDER)/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \
    $(COMMON_FOLDER)/default.prop:/root/default.prop
endif

DEVICE_PACKAGE_OVERLAYS := $(DEVICE_FOLDER)/overlay/aosp

# Audio Support
PRODUCT_PACKAGES += \
    libaudioutils \
    Music \
    tinyplay \
    tinymix \
    tinycap \
    audio_policy.default \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    audio.primary.$(TARGET_BOOTLOADER_BOARD_NAME) \
    audio.hdmi.$(TARGET_BOOTLOADER_BOARD_NAME)

# Codecs
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/etc/media_codecs.xml:/system/etc/media_codecs.xml \
    $(COMMON_FOLDER)/prebuilt/etc/media_profiles.xml:/system/etc/media_profiles.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Dalvik
PRODUCT_TAGS += dalvik.gc.type-precise

# Device settings
ADDITIONAL_BUILD_PROPERTIES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.opengles.version=131072 \
    com.ti.omap_enhancement=true \
    omap.enhancement=true \
    ro.crypto.state=unencrypted \
    persist.lab126.chargeprotect=1 \
    persist.sys.usb.config=mtp,adb \
    persist.sys.root_access=3 \
    ro.bq.gpu_to_cpu_unsupported=1 \
    media.stagefright.cache-params=18432/20480/15 \
    ro.ksm.default=1 \
    camera2.portability.force_api=1

# Deeper Sleep / Better Battery Life
ADDITIONAL_BUILD_PROPERTIES += \
    ro.ril.disable.power.collapse=1 \
    pm.sleep_mode=1

# DRM
PRODUCT_PACKAGES += \
    libwvm

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    sdcard \
    e2fsck \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs

# Graphics
PRODUCT_PACKAGES += \
    hwcomposer.$(TARGET_BOOTLOADER_BOARD_NAME)

# GPS
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/etc/gps.conf:/system/etc/gps.conf

# Lights
PRODUCT_PACKAGES += \
    lights.$(TARGET_BOOTLOADER_BOARD_NAME)

# Power
PRODUCT_PACKAGES += \
    power.$(TARGET_BOOTLOADER_BOARD_NAME)

# Low-RAM optimizations
ADDITIONAL_BUILD_PROPERTIES += \
    ro.config.low_ram=true \
    persist.sys.force_highendgfx=true \
    dalvik.vm.jit.codecachesize=0 \
    config.disable_atlas=true \
    ro.config.max_starting_bg=8 \
    ro.sys.fw.bg_apps_limit=16 \
    ro.hwui.disable_scissor_opt=false \
    config.disable_atlas=true \
    debug.hwui.render_dirty_regions=false

# Misc / Testing
PRODUCT_PACKAGES += \
    evtest \
    strace \
    libjni_pinyinime \
    sh

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    $(call add-to-product-copy-files-if-exists,packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml)

# Ramdisk
PRODUCT_PACKAGES += \
    init.amazon.omap4.rc

# Wifi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

$(call inherit-product-if-exists, vendor/ti/omap4/omap4-vendor.mk)
$(call inherit-product-if-exists, vendor/widevine/arm-generic/widevine-vendor.mk)

