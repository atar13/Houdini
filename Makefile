export ARCHS = arm64 arm64e
export SDKVERSION = 13.3

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Houdini

Houdini_FILES = Tweak.x
Houdini_CFLAGS = -fobjc-arc
Houdini_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += houdiniprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
