WPEFRAMEWORK_LAUNCHER_VERSION = 2f425ac9d08aa84927f88ee8f3576e9006b8783b
WPEFRAMEWORK_LAUNCHER_SITE_METHOD = git
WPEFRAMEWORK_LAUNCHER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginLauncher.git
WPEFRAMEWORK_LAUNCHER_INSTALL_STAGING = YES
WPEFRAMEWORK_LAUNCHER_DEPENDENCIES = wpeframework

WPEFRAMEWORK_LAUNCHER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_LAUNCHER_VERSION}

$(eval $(cmake-package))

