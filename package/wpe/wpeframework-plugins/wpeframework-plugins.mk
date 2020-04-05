################################################################################
#
# wpeframework-plugins
#
################################################################################

WPEFRAMEWORK_PLUGINS_VERSION = R1
WPEFRAMEWORK_PLUGINS_SITE = $(call github,rdkcentral,ThunderNanoServices,$(WPEFRAMEWORK_PLUGINS_VERSION))
WPEFRAMEWORK_PLUGINS_INSTALL_STAGING = YES
WPEFRAMEWORK_PLUGINS_DEPENDENCIES = wpeframework libpng

# wpeframework-netflix binary package config
WPEFRAMEWORK_PLUGINS_OPKG_NAME = "wpeframework-plugins"
WPEFRAMEWORK_PLUGINS_OPKG_VERSION = "1.0.0"
WPEFRAMEWORK_PLUGINS_OPKG_ARCHITECTURE = "${BR2_ARCH}"
WPEFRAMEWORK_PLUGINS_OPKG_MAINTAINER = "Metrological"
WPEFRAMEWORK_PLUGINS_OPKG_DESCRIPTION = "WPEFramework plugins"

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PLUGINS_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_DEBUG),y)
        WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_TYPE=Debug
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_DEBUG_OPTIMIZED),y)
        WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_TYPE=DebugOptimized
else ifeq ($( BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_RELEASE_WITH_SYMBOLS),y)
        WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_TYPE=ReleaseSymbols
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_RELEASE),y)
        WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_TYPE=Release
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_PRODUCTION),y)
        WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_TYPE=Production
endif
# libprovision

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT=ON
ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COBALT_STARBOARD_CONFIGURATION_INCLUDE="third_party/starboard/wpe/brcm/arm/configuration_public.h"
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COBALT_STARBOARD_CONFIGURATION_INCLUDE="third_party/starboard/wpe/rpi/configuration_public.h"
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_AUTOSTART=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_OUTOFPROCESS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_OUTOFPROCESS=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_OUTOFPROCESS=false
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMMANDER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMMANDER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEVICEINFO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISPLAYINFO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DISPLAYINFO=ON
endif

ifeq  ($(BR2_PACKAGE_WPEFRAMEWORK_DEVICEIDENTIFICATION),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DEVICEIDENTIFICATION=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DSRESOLUTION),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DSRESOLUTION=ON
ifeq ($(BR2_PACKAGE_DSRESOLUTION_WITH_DUMMY_DSHAL), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DDSRESOLUTION_WITH_DUMMY_DSHAL=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_RESOLUTION_720P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_RESOLUTION=720p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_RESOLUTION_1080P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_RESOLUTION=1080p50Hz
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_RESOLUTION_2160P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_RESOLUTION=2160p50Hz
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DHCPSERVER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DHCPSERVER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER=ON

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_HAS_YOUTUBE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_ENABLE_YOUTUBE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_MODE_ACTIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_MODE="active"
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_CALLSIGN),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_CALLSIGN="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_CALLSIGN))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_MODE_PASSIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_MODE="passive"
endif
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_NETFLIX),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_ENABLE_NETFLIX=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_MODE_ACTIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NETFLIX_MODE="active"
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_CALLSIGN),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NETFLIX_CALLSIGN="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_CALLSIGN))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_MODE_PASSIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NETFLIX_MODE="passive"
endif
endif

endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DICTIONARY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DICTIONARY=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_PIN),)
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PAIRING_PIN=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_PIN}
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PAIRING_CALLSIGN=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_CALLSIGN}
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PAIRING_PRODUCER=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_PRODUCER}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_REPORTING_PIN),)
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_REPORTING_PIN=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_REPORTING_PIN}
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_INPUTSWITCH),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_INPUTSWITCH=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EGLTEST),y)
WPEFRAMEWORK_COMMON_CONF_OPTS += -DPLUGIN_EGLTEST=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_FRONTPANEL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_FRONTPANEL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_LOCATIONSYNC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_LOCATIONSYNC=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_LOCATIONSYNC_URI=${BR2_PACKAGE_WPEFRAMEWORK_LOCATIONSYNC_URI}
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_MONITOR=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_WEBKIT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_WEBKIT}
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_YOUTUBE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_YOUTUBE_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_YOUTUBE}
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_AMAZON),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_AMAZON}
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_APPS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_APPS_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_APPS}
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_UX),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_UX_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_UX}
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_NETFLIX),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETFLIX=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETFLIX_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_NETFLIX}
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_NETWORKCONTROL),y)
ifeq ($(BR2_TARGET_GENERIC_NETWORK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETWORKCONTROL_SYSTEM_NETWORK=ON
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETWORKCONTROL=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_AUTOSTART=true
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_OOP=true
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_USER),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_USER=$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_USER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_GROUP=$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_CLEARKEY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_CLEARKEY=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-clearkey
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-playready
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_NEXUS=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-playready-nexus
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_NEXUS=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-playready-nexus-svp
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_VGDRM=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-playready-vgdrm
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_WIDEVINE=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-widevine
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DOPENCDMI_WIDEVINE_NEXUS_SVP=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-widevine-nexus-svp
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_NAGRA),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_NAGRA=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-nagra
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_NCAS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OPENCDMI_NCAS=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-cdmi-ncas
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_AUTOSTART=true
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH_PERSISTMAC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_PERSISTMAC=true
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_OOP=false
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += bluez5_utils
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHREMOTECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHREMOTECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_DEVINPUT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_DEVINPUT=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += udev
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_IR=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IR_CODEMASK),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CODEMASK="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IR_CODEMASK))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_CUSTOM_VIRTUAL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CUSTOM_VIRTUAL_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_CUSTOM_VIRTUAL_NAME))"
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CUSTOM_VIRTUAL_MAP_FILE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_CUSTOM_VIRTUAL_MAP_FILE))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SNAPSHOT),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += libpng
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SNAPSHOT=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SYSTEMCOMMANDS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SYSTEMCOMMANDS=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_FILETRANSFER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_FILETRANSFER=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TESTCONTROLLER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TESTCONTROLLER=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLEJSONRPC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_JSONRPC=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TESTUTILITY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TESTUTILITY=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TIMESYNC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TIMESYNC=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TIMESYNC_DEFFERED),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TIMESYNC_DEFFERED=ON
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TRACECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TRACECONTROL=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VOLUMECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_VOLUMECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpewebkit
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_AMAZON_HAWAII),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_HAWAII=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_AUTOSTART=false
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_STARTURL),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_STARTURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_STARTURL)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_USERAGENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_USERAGENT=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_USERAGENT)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_MEMORYPROFILE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEMORYPROFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_MEMORYPROFILE)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_MEMORYPRESSURE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEMORYPRESSURE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_MEMORYPRESSURE)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_MEDIADISKCACHE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEDIADISKCACHE=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_DISKCACHE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_DISKCACHE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_DISKCACHE)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_XHRCACHE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_XHRCACHE=false
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_CLIENTIDENTIFIER),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_CLIENTIDENTIFIER=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_CLIENTIDENTIFIER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_LOCALSTORAGE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_LOCALSTORAGE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_LOCALSTORAGE)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_COOKIESTORAGE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_COOKIESTORAGE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_COOKIESTORAGE)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_WINDOWCLOSE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_WINDOWCLOSE=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_WINDOWCLOSE=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_DISABLE_WEBGL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_WEBGL=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_TRANSPARENT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_TRANSPARENT=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_TRANSPARENT=false
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_THREADEDPAINTING),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_THREADEDPAINTING=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_THREADEDPAINTING)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_USER),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_USER=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_USER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_GROUP),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_GROUP=$(BR2_PACKAGE_WPEFRAMEWORK_WEBKITBROWSER_GROUP)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BROWSER_RESOLUTION_720P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_RESOLUTION=720p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BROWSER_RESOLUTION_1080P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_RESOLUTION=1080p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BROWSER_RESOLUTION_2160P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_RESOLUTION=2160p
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_YOUTUBE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_YOUTUBE=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_YOUTUBE_USERAGENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_YOUTUBE_USERAGENT=$(BR2_PACKAGE_WPEFRAMEWORK_YOUTUBE_USERAGENT)
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_TAB),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_AMAZON=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_STARTURL),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_STARTURL=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_STARTURL)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USERAGENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_USERAGENT=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USERAGENT)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USER),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_USER=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_USER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_GROUP),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_GROUP=$(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_GROUP)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AMAZON_TRANSPARENT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_TRANSPARENT=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_TRANSPARENT=false
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AMAZON_HAWAII=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_APPS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_APPS=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_APPS_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_APPS_AUTOSTART=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_APPS_USERAGENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_APPS_USERAGENT=$(BR2_PACKAGE_WPEFRAMEWORK_APPS_USERAGENT)
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_UX),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_UX=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_UX_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_UX_AUTOSTART=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_UX_USERAGENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_UX_USERAGENT=$(BR2_PACKAGE_WPEFRAMEWORK_UX_USERAGENT)
endif
endif
endif

ifeq ($(BR2_PACKAGE_PLUGIN_RTSPCLIENT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_RTSPCLIENT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += parodus libparodus tinyxml
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_AUTOSTART=true
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_SERVICE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_SERVICE=true
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_PINGWAITTIME=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_PINGWAITTIME)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_WEBPAURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_WEBPAURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_PARODUSLOCALURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_PARODUSLOCALURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_PARTENRID=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_PARTENRID)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_BACKOFFMAX=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_BACKOFFMAX)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CERTPATH=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CERTPATH)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_GENERIC_ADAPTER), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_GENERIC_ADAPTER=true
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_GENERICCLIENTURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_GENERICCLIENTURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_DATAMODELFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_DATAMODELFILE)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_NOTIFYCONFIGFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_NOTIFYCONFIGFILE)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_DEVICE_INFO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_DEVICE_INFO=true
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += procps-ng
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSP), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP=true
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += parodus2ccsp
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP_CLIENTURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSPCLIENTURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP_CONFIGFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSP_DATAFILE)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP_DATAFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSP_CONFIGFILE)
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPROXY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPROXY=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PATH)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PORT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER_PORT=$(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PORT)
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSHELL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSHELL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WIFICONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WIFICONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PACKAGER),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += opkg
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PACKAGER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLAYERINFO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PLAYERINFO=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER_AUTOSTART=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOPIN),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER_GPIOPIN=$(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOPIN)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOTYPE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER_GPIOTYPE=$(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOTYPE)
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGINPROCESSCONTAINERS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSCONTAINERS=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGINPROCESSCONTAINERS_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSCONTAINERS_AUTOSTART=true
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSMONITOR=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSMONITOR_AUTOSTART=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR_EXITTIMEOUT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSMONITOR_EXITTIMEOUT=${BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR_EXITTIMEOUT}
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_DECODERS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_DECODERS))
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE),y)
PLUGIN_STREAMER_IMPLEMENTATIONS += QAM
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_ANNEX_A),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=A
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_ANNEX_B),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=B
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_ANNEX_C),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=C
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=NoAnnex
endif
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_FRONTENDS))
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_SATELLITE),y)
PLUGIN_STREAMER_IMPLEMENTATIONS += QAM
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_SATELLITE_ANNEX_A),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE_ANNEX=A
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE_ANNEX=NoAnnex
endif
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_SATELLITE_FRONTENDS))
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TERRESTRIAL),y)
PLUGIN_STREAMER_IMPLEMENTATIONS += QAM
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TERRESTRIAL_ANNEX_A),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL_ANNEX=A
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL_ANNEX=NoAnnex
endif
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TERRESTRIAL_FRONTENDS))
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TS_SCANNING),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TS_SCANNING=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_HOME_TS=$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_HOME_TS)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_STANDARD=DVB
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_ATSC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_STANDARD=ATSC
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_ISDB),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_STANDARD=ISDB
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_AAMP), y)
PLUGIN_STREAMER_IMPLEMENTATIONS += Aamp
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_AAMP_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_AAMP_FRONTENDS))
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_AAMP_USE_WESTEROS_SINK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_AAMP_WESTEROSSINK=ON
endif
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += gst1-aamp
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_IMPLEMENTATIONS="$(PLUGIN_STREAMER_IMPLEMENTATIONS)"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SPARK),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += spark
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SPARK=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SPARK_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=false
endif

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLATFORM_LINUX=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLATFORM_WPEFRAMEWORK=ON
else ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLATFORM_WAYLAND_EGL=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MESSENGER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_MESSENGER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SECURITYAGENT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SECURITYAGENT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_RPCLINK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_RPCLINK=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR=ON
ifneq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DNEXUS_SERVER_HAS_EXTENDED_INIT=OFF
endif
ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += westeros
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Wayland
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SUB_IMPLEMENTATION=Westeros
else ifeq  ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += bcm-refsw
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
else ifeq  ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
else ifeq  ($(BR2_PACKAGE_RPI_FIRMWARE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=RPI
else
$(error Missing a compositor implemtation, please provide one or disable PLUGIN_COMPOSITOR)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_OUTOFPROCESS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_OUTOFPROCESS=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_OUTOFPROCESS=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_AUTOSTART=false
endif
ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_NXSERVER=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_NEXUS_SERVER_EXTERNAL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DNEXUS_SERVER_EXTERNAL=ON
else
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_IRMODE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IRMODE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_IRMODE))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_BOXMODE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_BOXMODE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_BOXMODE))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_SAGE_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SAGE_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_PAK_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_PAK_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_PAK_PATH))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_DRM_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_DRM_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_DRM_PATH))"
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SVP_NONE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="None"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SVP_VIDEO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="Video"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SVP_ALL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="All"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_GFX="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX2),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_GFX2="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX2))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_RESTRICTED),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_RESTRICTED="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_RESTRICTED))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_MAIN),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_MAIN="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_MAIN))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_EXPORT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_EXPORT="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_EXPORT))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_SECUREGFX),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_SECUREGFX="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_SECUREGFX))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_CLIENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_CLIENT="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_CLIENT))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS=false
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS=true
endif
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_VIRTUALINPUT=ON
endif

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_HARDWAREREADY=${BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_HARDWAREREADY}

define WPEFRAMEWORK_COMPOSITOR_POST_TARGET_REMOVE_HEADERS
    rm -rf $(TARGET_DIR)/usr/include/WPEFramework
endef

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_INSTALL_HEADERS),y)
WPEFRAMEWORK_PLUGINS_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_COMPOSITOR_POST_TARGET_REMOVE_HEADERS
endif

endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CREATE_IPKG_TARGETS),y)
$(call SIMPLE_OPKG_TOOLS_CREATE_CPACK_METADATA,WPEFRAMEWORK_PLUGINS)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DWPEFRAMEWORK_CREATE_IPKG_TARGETS=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += ${WPEFRAMEWORK_PLUGINS_OPKG_CPACK_METADATA}

WPEFRAMEWORK_PLUGINS_POST_BUILD_HOOKS += SIMPLE_OPKG_TOOLS_MAKE_PACKAGE
WPEFRAMEWORK_PLUGINS_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_PLUGINS_INSTALL_IPKG_CMDS

define WPEFRAMEWORK_PLUGINS_INSTALL_IPKG_CMDS
    $(eval PACKAGE_NAME_PREFIX := ${WPEFRAMEWORK_PLUGINS_OPKG_NAME}_${WPEFRAMEWORK_PLUGINS_OPKG_VERSION}_${WPEFRAMEWORK_PLUGINS_OPKG_ARCHITECTURE})
    $(call SIMPLE_OPKG_TOOLS_INSTALL_PACKAGE,${@D}/${PACKAGE_NAME_PREFIX}-WPEFrameworkWebKitBrowser.deb)
    $(call SIMPLE_OPKG_TOOLS_INSTALL_PACKAGE,${@D}/${PACKAGE_NAME_PREFIX}-WPEInjectedBundle.deb)

    $(call SIMPLE_OPKG_TOOLS_REMOVE_FROM_TARGET)
endef # WPEFRAMEWORK_PLUGINS_INSTALL_TARGET_CMDS

endif # ($(BR2_PACKAGE_WPEFRAMEWORK_CREATE_IPKG_TARGETS),y)

$(eval $(cmake-package))
