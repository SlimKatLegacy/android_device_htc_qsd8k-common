#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# English locale
PRODUCT_LOCALES := en

# High Density art
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Configs
PRODUCT_COPY_FILES += \
    device/htc/qsd8k-common/media_codecs.xml:system/etc/media_codecs.xml \
    device/htc/qsd8k-common/audio_policy.conf:system/etc/audio_policy.conf

# Misc
PRODUCT_COPY_FILES += \
    device/htc/qsd8k-common/init.power.rc:root/init.power.rc

#
# Required Packages
#

# Audio
PRODUCT_PACKAGES += \
    audio.usb.default \
    audio.a2dp.default \
    audio.primary.qsd8k \
    audio_policy.qsd8k

# Camera
PRODUCT_PACKAGES += \
    camera.qsd8k

# Display
PRODUCT_PACKAGES += \
    copybit.qsd8k \
    gralloc.qsd8k \
    hwcomposer.qsd8k

# Omx
PRODUCT_PACKAGES += \
    libOmxCore \
    libOmxVdec \
    libstagefrighthw
#    libOmxVidEnc \

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# Misc
PRODUCT_PACKAGES += \
    power.qsd8k \
    com.android.future.usb.accessory

#
# Hardware Rendering Properties
#

PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    debug.sf.no_hw_vsync=1 \
    debug.composition.type=mdp \
    debug.egl.profiler=1 \
    debug.egl.hw=1 \
    debug.composition.type=gpu \
    debug.gr.numframebuffers=2 \
    debug.performance.tuning=1 \
    persist.sys.ui.hw=1 \
    persist.webview.provider=classic \
    video.accelerate.hw=1 \
    view.scroll_friction=0 \
    ro.zygote.disable_gl_preload=true

#
# HWUI TWEAKS (credits pixelfreak & walter79)
#

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.disable_scissor_opt=false \
    ro.hwui.texture_cache_size=24 \
    ro.hwui.layer_cache_size=16 \
    ro.hwui.gradient_cache_size=0.5 \
    ro.hwui.patch_cache_size=128 \
    ro.hwui.path_cache_size=4 \
    ro.hwui.shape_cache_size=1 \
    ro.hwui.drop_shadow_cache_size=2 \
    ro.hwui.r_buffer_cache_size=2 \
    ro.hwui.texture_cache_flush_rate=0.6 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=256 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=512 \
    hwui.text_gamma_correction=lookup \
    hwui.text_gamma=1.4 \
    hwui.text_gamma.black_threshold=64 \
    hwui.text_gamma.white_threshold=192 \
    hwui.use_gpu_pixel_buffers=true \
    hwui.render_dirty_regions=false \
    hwui.use.blacklist=true

# WEBVIEW / is only for 2.x kernel and this fix blackscreen in google apps
PRODUCT_PROPERTY_OVERRIDES += \
    persist.webview.provider=classic

# DISABLE ERROR CHECKING
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0

# MULTI-CORE DEX OPT DISABLED
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.dalvik.multithread=false

#
# Low Mem tweaks
#
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
# Disable jit
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.jit.codecachesize=0
# Enable Allow purging of assets
PRODUCT_PROPERTY_OVERRIDES += persist.sys.purgeable_assets=1
# Disable atlas service at start-up to save memory
PRODUCT_PROPERTY_OVERRIDES += \
    config.disable_atlas=true

#
# Battery tweaks
#
PRODUCT_PROPERTY_OVERRIDES += \
    ro.mot.eri.losalert.delay=1000 \
    pm.sleep_mode=1 \
    ro.ril.power_collapse=1
    
#
# Telephony/ring Tweaks
#
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.call_ring.delay=3000

#
# Proximity (Disable blackscreen issue after call)
#
PRODUCT_PROPERTY_OVERRIDES += \
    mot.proximity.delay=25 \
    ro.lge.proximity.delay=25 \
    ring.delay=0

#
# Scrolling tweaks
#
PRODUCT_PROPERTY_OVERRIDES += \
    ro.min_pointer_dur=8 \
    ro.max.fling_velocity=12000 \
    ro.min.fling_velocity=8000 \
    windowsmgr.max_events_per_sec=120

#
# Dalvik Properties
#
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=48m \
    dalvik.vm.heapsize=64m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y \
    ro.sys.fw.bg_apps_limit=12 \
    dalvik.vm.checkjni=false

# MAKES APPS LOAD FASTER AND FREES MORE RAM
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-flags=v=a,o=v,m=y,u=y

# Default heap settings for 512mb device
include frameworks/native/build/phone-hdpi-512-dalvik-heap.mk

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

#
# Camera (video recording)
#

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
    debug.camcorder.disablemeta=1 \
    rw.media.record.hasb=0

#
# Wifi
#

# Firmware
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=180

#
# Qcom
#

# Init post-boot script
PRODUCT_COPY_FILES += \
    device/htc/qsd8k-common/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh

#
# Permissions
#

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distict.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Proprietary blobs
$(call inherit-product-if-exists, vendor/htc/qsd8k-common/qsd8k-vendor.mk)
