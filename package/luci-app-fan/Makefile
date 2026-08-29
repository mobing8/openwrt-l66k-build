include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-fan
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Fan Temperature Control
  DEPENDS:=+kmod-thermal +kmod-hwmon-core
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
  LuCI application for automatic fan control based on CPU temperature.
  Supports custom temperature thresholds for fan on/off.
  温控风扇控制：根据 CPU 温度自动控制风扇启停，支持自定义温度阈值。
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/fan-control $(1)/etc/init.d/fan-control
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/fan $(1)/etc/config/fan
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/fan.lua $(1)/usr/lib/lua/luci/controller/fan.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/fan.lua $(1)/usr/lib/lua/luci/model/cbi/fan.lua
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
