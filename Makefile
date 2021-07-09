ARCHS = arm64 arm64e
# export SDKVERSION = 13.5
SDKVERSION = 14.3
SYSROOT = $(THEOS)/sdks/iPhoneOS14.3.sdk

TARGET := iphone:clang:13.0:latest
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Houdini

Houdini_FILES = Houdini.x
Houdini_CFLAGS = -fobjc-arc
Houdini_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += houdiniprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
