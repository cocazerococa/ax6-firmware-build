#!/bin/bash
set -e
export GIT_TERMINAL_PROMPT=0

# PassWall feed
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> feeds.conf.default
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> feeds.conf.default

# OpenClash feed（master 分支更稳定）
echo "src-git openclash https://github.com/vernesong/OpenClash.git;master" >> feeds.conf.default

# iStore feed
echo "src-git istore https://github.com/linkease/istore.git;main" >> feeds.conf.default
echo "src-git istore_data https://github.com/linkease/istore-pkg-data.git;main" >> feeds.conf.default

# 修改默认主机名
sed -i "s/ImmortalWrt/RedmiAX6-NSS/g" \
  package/base-files/files/bin/config_generate 2>/dev/null || true

# 修改默认 LAN IP
sed -i 's/192\.168\.1\.1/192.168.100.1/g' \
  package/base-files/files/bin/config_generate 2>/dev/null || true

# ── 中文语言：直接写入 squashfs ──────────────────────────────
# 方法1：直接写 /etc/config/luci（最可靠，随只读层打包进去）
mkdir -p files/etc/config
cat > files/etc/config/luci << 'LUCIEOF'
config core main
	option lang zh-cn
	option mediaurlbase /luci-static/bootstrap
	option resourcebase /luci-static/resources
LUCIEOF

# 方法2：UCI defaults（首次启动再写一次，覆盖任何默认值）
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/99-set-lang.sh << 'EOF'
#!/bin/sh
uci -q set luci.main.lang=zh-cn
uci commit luci
exit 0
EOF
chmod +x files/etc/uci-defaults/99-set-lang.sh

echo "[DIY] feeds / 主机名 / IP / 中文语言 已设置"
