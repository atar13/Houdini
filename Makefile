export ARCHS = arm64 arm64e
export SDKVERSION = 13.3

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Houdini

Houdini_FILES = Tweak.x
Houdini_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
