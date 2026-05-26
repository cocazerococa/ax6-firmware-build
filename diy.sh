#!/bin/bash
# DIY 脚本：在 feeds update 之前执行
set -e
# 修改默认主机名
sed -i "s/ImmortalWrt/RedmiAX6-NSS/g" \
  package/base-files/files/bin/config_generate 2>/dev/null || true
echo "[DIY] 主机名已设置为 RedmiAX6-NSS"
