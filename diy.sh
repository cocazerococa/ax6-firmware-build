#!/bin/bash
set -e
export GIT_TERMINAL_PROMPT=0

# PassWall feed
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> feeds.conf.default
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> feeds.conf.default

# OpenClash feed（master 分支更稳定）
echo "src-git openclash https://github.com/vernesong/OpenClash.git;master" >> feeds.conf.default

# 修改默认主机名
sed -i "s/ImmortalWrt/RedmiAX6-NSS/g" \
  package/base-files/files/bin/config_generate 2>/dev/null || true

# 修改默认 LAN IP
sed -i 's/192\.168\.1\.1/192.168.100.1/g' \
  package/base-files/files/bin/config_generate 2>/dev/null || true

echo "[DIY] feeds 已添加，主机名/IP 已设置"
