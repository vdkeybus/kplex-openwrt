##############################################
# OpenWrt Makefile for kplex                 #
# Copyright (C) Caesar Schinas 2014          #
##############################################

include $(TOPDIR)/rules.mk

# Name and release number of this package
PKG_NAME:=kplex
PKG_VERSION:=1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://www.stripydog.com/download
PKG_MD5SUM:=7b37172c04f820c4e43892c4b4f686d6

PKG_LICENSE:=GPL-3.0+

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)


include $(INCLUDE_DIR)/package.mk


# Specify package information for this program. 
define Package/kplex
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=kplex NMEA multiplexer
	URL:=http://www.stripydog.com/kplex/
	DEPENDS:=+libpthread
endef
define Package/kplex/description
	kplex -- an NMEA multiplexer for Linux
	kplex combines, filters and prioritises NMEA-0183 data from various types of
	inputs (serial, network, flie, pseudo terminal) and sends it to various outputs
endef

# Tell OPKG where the config file is so it doesn't overwrite it when updating.
# Note: This block must not be indented.
define Package/kplex/conffiles
/etc/kplex.conf
endef


# Use local source code instead of downloading it from $(PKG_SOURCE_URL)/$(PKG_SOURCE).
#define Build/Prepare
#	mkdir -p $(PKG_BUILD_DIR)
#	$(CP) ./src/* $(PKG_BUILD_DIR)/
#endef


# Specify where and how to install the program.
# The $(1) variable represents the root directory on the router.
define Package/kplex/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/kplex $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/kplex.conf.ex $(1)/etc/kplex.conf
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/kplex.init $(1)/etc/init.d/kplex
endef


$(eval $(call BuildPackage,kplex))