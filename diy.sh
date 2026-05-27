#!/bin/bash
set -e

# 添加 PassWall feed
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> feeds.conf.default
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> feeds.conf.default

# 添加 OpenClash feed
echo "src-git openclash https://github.com/vernesong/OpenClash.git;dev" >> feeds.conf.default

# 修改默认主机名
sed -i "s/ImmortalWrt/RedmiAX6-NSS/g" \
  package/base-files/files/bin/config_generate 2>/dev/null || true

# 修改默认 LAN IP 为 192.168.100.1
sed -i 's/192\.168\.1\.1/192.168.100.1/g' \
  package/base-files/files/bin/config_generate 2>/dev/null || true

echo "[DIY] 主机名: RedmiAX6-NSS | LAN IP: 192.168.100.1"
echo "[DIY] feeds: passwall + openclash 已添加"
