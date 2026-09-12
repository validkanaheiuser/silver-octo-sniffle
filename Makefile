THEOS_PACKAGE_SCHEME = roothide
TARGET = iphone:latest:15.0
ARCHS = arm64 arm64e

FINALPACKAGE ?= 1
DEBUG ?= 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = InjectTest
InjectTest_FILES = Tweak.x
InjectTest_FILTER = com.mbv.mobilebanking
InjectTest_CFLAGS = -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
