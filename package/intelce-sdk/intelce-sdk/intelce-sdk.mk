################################################################################
#
# Intelce sdk target
#
################################################################################
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SDK_VERSION = eef93375337a2aa2252d2b828d4b2cfa6db6b658
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_SDK_VERSION = e5870c1fdcf438cbeaef07e912eedacca322bcdc
endif

INTELCE_SDK_SITE = git@github.com:Metrological/IntelCE-SDK.git
INTELCE_SDK_SITE_METHOD = git
INTELCE_SDK_DEPENDENCIES = host-doxygen host-dos2unix

$(eval $(generic-package))
