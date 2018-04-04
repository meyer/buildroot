################################################################################
#
# WPEFramework
#
################################################################################

WPEFRAMEWORK_VERSION = f64ed25d6cccd4e87f2451428d9b762d8c888828
WPEFRAMEWORK_SITE_METHOD = git
WPEFRAMEWORK_SITE = git@github.com:WebPlatformForEmbedded/WPEFramework.git
WPEFRAMEWORK_INSTALL_STAGING = YES
WPEFRAMEWORK_DEPENDENCIES = zlib

WPEFRAMEWORK_CONF_OPTS += -DBUILD_REFERENCE=$(WPEFRAMEWORK_VERSION) -DTREE_REFERENCE=$(shell $(GIT) rev-parse HEAD)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PORT=$(BR2_PACKAGE_WPEFRAMEWORK_PORT)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_BINDING=$(BR2_PACKAGE_WPEFRAMEWORK_BIND)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_IDLE_TIME=$(BR2_PACKAGE_WPEFRAMEWORK_IDLE_TIME)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PERSISTENT_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_PERSISTENT_PATH)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_DATA_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_DATA_PATH)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_SYSTEM_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_SYSTEM_PATH)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PROXYSTUB_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_PROXYSTUB_PATH)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_OOMADJUST=$(BR2_PACKAGE_WPEFRAMEWORK_OOM_ADJUST)


# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_WEBSERVER_PATH=
# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_WEBSERVER_PORT=
# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_CONFIG_INSTALL_PATH=
# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_IPV6_SUPPORT=
# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PRIORITY=
# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_POLICY=
# WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_STACKSIZE=

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
#WPEFRAMEWORK_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_TEST_APPS=ON -DWPEFRAMEWORK_TEST_LOADER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VERBOSE_BUILD),y)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_VERBOSE_BUILD=ON
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_SYSTEM_PREFIX),"")
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_SYSTEM_PREFIX="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_SYSTEM_PREFIX))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)		
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_VIRTUALINPUT=ON		
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_CDMI=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY),y)		
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PROVISIONPROXY=ON		
WPEFRAMEWORK_DEPENDENCIES = libprovision
WPEFRAMEWORK_EXTERN_EVENTS += Provisioning
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_LOCATIONSYNC),y)
WPEFRAMEWORK_EXTERN_EVENTS += Internet
WPEFRAMEWORK_EXTERN_EVENTS += Location
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TIMESYNC),y)
WPEFRAMEWORK_EXTERN_EVENTS += Time
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
WPEFRAMEWORK_EXTERN_EVENTS += Platform
WPEFRAMEWORK_EXTERN_EVENTS += Graphics
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_NETWORKCONTROL),y)
WPEFRAMEWORK_EXTERN_EVENTS += Network
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI),y)
WPEFRAMEWORK_EXTERN_EVENTS += Decryption
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER),y)
WPEFRAMEWORK_EXTERN_EVENTS += WebSource
endif

WPEFRAMEWORK_CONF_OPTS += -DEXTERN_EVENTS="${WPEFRAMEWORK_EXTERN_EVENTS}"


ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_NETWORKCONTROL),y)
define WPEFRAMEWORK_POST_TARGET_INITD
	mkdir -p $(TARGET_DIR)/etc/init.d
	$(INSTALL) -D -m 0755 $(WPEFRAMEWORK_PKGDIR)/S80WPEFramework $(TARGET_DIR)/etc/init.d/S40WPEFramework
endef
else
define WPEFRAMEWORK_POST_TARGET_INITD
	mkdir -p $(TARGET_DIR)/etc/init.d
	$(INSTALL) -D -m 0755 $(WPEFRAMEWORK_PKGDIR)/S80WPEFramework $(TARGET_DIR)/etc/init.d
endef
endif

define WPEFRAMEWORK_POST_TARGET_REMOVE_STAGING_ARTIFACTS
	mkdir -p $(TARGET_DIR)/etc/WPEFramework
	rm -rf $(TARGET_DIR)/usr/share/WPEFramework/cmake
endef

define WPEFRAMEWORK_POST_TARGET_REMOVE_HEADERS
	rm -rf $(TARGET_DIR)/usr/include/WPEFramework
endef

define WPEFRAMEWORK_POST_STAGING_CDM_HEADER
	ln -sfn $(STAGING_DIR)/usr/include/WPEFramework/interfaces/IDRM.h $(STAGING_DIR)/usr/include/cdmi.h
endef

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
WPEFRAMEWORK_POST_INSTALL_STAGING_HOOKS += WPEFRAMEWORK_POST_STAGING_CDM_HEADER
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DISABLE_INITD),y)
WPEFRAMEWORK_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_POST_TARGET_INITD
endif

WPEFRAMEWORK_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_POST_TARGET_REMOVE_STAGING_ARTIFACTS
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_INSTALL_HEADERS),y)
WPEFRAMEWORK_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_POST_TARGET_REMOVE_HEADERS
endif

$(eval $(cmake-package))
