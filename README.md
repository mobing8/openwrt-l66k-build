# OpenWrt L66K (X55) 固件编译

基于启明智显开源仓库 [openwrt-24-open](https://gitee.com/qiming-zhixian/openwrt-24-open) (OpenWrt 24.10 + Linux 6.6) 定制编译。

## 目标机型
- **L66K** (高通 X55 5G 模块, MT7981B, aarch64)

## 固件特性

| 功能 | 说明 |
|---|---|
| 基础路由 | LAN/WAN、防火墙、DHCP、WiFi、SSH、LuCI |
| 默认 IP | `192.168.66.1/24`，DHCP 地址池 100-249 |
| 默认语言 | 简体中文 (zh-cn) |
| 默认主题 | Argon |
| OpenClash | luci-app-openclash，不内置内核，刷机后网页端下载 |
| 5G 模块管理 | QModem (luci-app-qmodem-next)，支持锁频段/锁小区/SA-NSA切换/sendat |
| USB-QMI 驱动 | kmod-usb-net, kmod-usb-net-qmi-wwan, kmod-usb-serial, uqmi, kmod-usb3, kmod-usb2 |
| 温控风扇 | luci-app-fan，根据 CPU 温度自动控制风扇启停，可自定义阈值 |
| 信号信息 | modeminfo-qmi (luci-app-modeminfo) |

## 编译方式

推送代码到 `main` 分支后，GitHub Actions 会自动触发编译。也可以在 Actions 页面手动触发。

编译产物在 Actions run 的 Artifacts 中下载。

## 目录结构

```
├── .github/workflows/build.yml    # GitHub Actions 编译工作流
├── config/l66k.config             # 增量配置（基于 L66K 默认配置）
├── files/etc/uci-defaults/        # 首次启动默认设置（IP/主题/语言）
├── package/luci-app-fan/          # 温控风扇 LuCI 应用
└── README.md
```

## 刷机注意

1. 第三方固件带自定义头部，建议先按 [zx-openwrt-port](https://gitee.com/qiming-zhixian/zx-openwrt-port) 教程刷 FIP
2. 刷机后访问 `http://192.168.66.1`
3. OpenClash 需在网页端下载 clash 内核
