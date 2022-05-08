#!/bin/sh -eux

# NODE_EXPORTER_VERSION is set by packer as environment variable
#NODE_EXPORTER_VERSION=1.3.1
NODE_EXPORTER_PORT=9300

echo "download software"
wget -q https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz -O /tmp/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

echo "untar software"
tar xzf /tmp/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz -C /opt

echo "remove tarball"
rm /tmp/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

echo "change ownership"
chown -R node_exporter.node_exporter /opt/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64

echo "create systemd unit file"
echo "[Unit]
Description=Prometheus Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/opt/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter --web.listen-address=:$NODE_EXPORTER_PORT

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/node_exporter.service
