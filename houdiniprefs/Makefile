# SDKVERSION = 14.3
# SYSROOT = $(THEOS)/sdks/iPhoneOS14.3.sdk
ARCHS = arm64 arm64e
SDKVERSION = 14.3
TARGET := iphone:clang:14.3:latest
SYSROOT = $(THEOS)/sdks/iPhoneOS14.3.sdk

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = houdiniprefs

houdiniprefs_FILES = HOUDINIRootListController.m
houdiniprefs_INSTALL_PATH = /Library/PreferenceBundles
houdiniprefs_FRAMEWORKS = UIKit
houdiniprefs_PRIVATE_FRAMEWORKS = Preferences
houdiniprefs_CFLAGS = -fobjc-arc
houdiniprefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/houdiniprefs.plist$(ECHO_END)
