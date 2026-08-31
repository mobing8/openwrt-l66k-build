# luci-app-syncthing

Syncthing 文件同步工具的 LuCI 管理界面（纯中文硬编码版）

## 版本

v1.0.9

## 改动点

### 相比源包 (shidahuilang/openwrt-package Lede 分支)

1. **菜单位置调整**：从 `NAS` 菜单移到 `服务` (services) 菜单下
2. **配置文件名修复**：源包 config 文件名为 `luci-app-syncthing`，但 controller/cbi 期望 `syncthing`，导致菜单不显示。已统一为 `syncthing`
3. **移除冲突文件**：不打包 `/etc/config/syncthing` 和 `/etc/init.d/luci-app-syncthing`，避免与 syncthing 主程序包文件冲突
4. **CBI 适配**：改用 `NamedSection` 适配 syncthing 主程序的配置格式；端口字段改为 `gui_address`（完整监听地址）
5. **纯中文硬编码**：所有界面文字直接写中文，不依赖 .po/.lmo 翻译文件，避免 OpenWrt 25.12 ucode 运行时翻译加载问题
6. **apk 格式**：使用 OpenWrt 25.12+ 的 apk 包格式（v3），兼容 MT7621 (mipsel_24kc) 等所有架构（noarch）

### 界面文字

| 位置 | 显示 |
|------|------|
| 左侧菜单 | 储存同步 |
| 页面标题 | Syncthing 同步工具 |
| 状态 | 运行中 / 未运行 |
| 设置区域 | 设置 |
| 开关 | 启用 |
| 输入框 | GUI 监听地址 |
| 加载提示 | 正在收集数据... |

## 依赖

- luci-base
- syncthing

## 安装

```bash
apk add syncthing
apk add --allow-untrusted luci-app-syncthing-1.0.9.apk
```

## 构建

基于 OpenWrt 25.12.5 ramips/mt7621 SDK 构建。
