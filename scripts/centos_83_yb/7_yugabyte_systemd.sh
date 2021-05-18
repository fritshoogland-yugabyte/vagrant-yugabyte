#!/bin/sh -eux
#
# MASTER
#
echo "create yb-master flagfile"
su -c "echo \"--master_addresses=127.0.0.1:7100
--rpc_bind_addresses=0.0.0.0
--fs_data_dirs=/mnt/d0
--placement_cloud=local
--placement_region=local
--placement_zone=local
--replication_factor=1\" > /opt/yugabyte/conf/master.conf" yugabyte

echo "create yb-master unit file"
echo "[Unit]
Description=Yugabyte master service
Requires=network-online.target
After=network.target network-online.target multi-user.target

[Service]
User=yugabyte
Group=yugabyte
LimitSIGPENDING=119934
LimitNOFILE=1048576
LimitNPROC=12000
EnvironmentFile=/opt/yugabyte/conf/home.environment
ExecStart=/bin/sh -c \"/opt/yugabyte/\$\${MASTER}/bin/yb-master --flagfile /opt/yugabyte/conf/master.conf\"
ExecStop=/bin/kill -s HUP \$MAINPID
Restart=on-failure
RestartSec=3s
KillSignal=SIGKILL
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=default.target" > /etc/systemd/system/yb-master.service
#
# TSERVER
#
echo "create yb-tserver flagfile"
su -c "echo \"--tserver_master_addrs=127.0.0.1:7100
--rpc_bind_addresses=0.0.0.0
--start_pgsql_proxy
--pgsql_proxy_bind_address=0.0.0.0:5433
--cql_proxy_bind_address=0.0.0.0:9042
--fs_data_dirs=/mnt/d0
--placement_cloud=local
--placement_region=local
--placement_zone=local\" > /opt/yugabyte/conf/tserver.conf" yugabyte

echo "create yb-tserver unit file"
echo "[Unit]
Description=Yugabyte tserver service
Requires=network-online.target
After=network.target network-online.target multi-user.target

[Service]
User=yugabyte
Group=yugabyte
LimitSIGPENDING=119934
LimitNOFILE=1048576
LimitNPROC=12000
EnvironmentFile=/opt/yugabyte/conf/home.environment
ExecStart=/bin/sh -c \"/opt/yugabyte/\$\${TSERVER}/bin/yb-tserver --flagfile /opt/yugabyte/conf/tserver.conf\"
ExecStop=/bin/kill -s HUP \$MAINPID
Restart=on-failure
RestartSec=3s
KillSignal=SIGKILL
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=default.target" > /etc/systemd/system/yb-tserver.service

#
# fake mountpoint
#
echo "create fake mountpoint for database files"
mkdir /mnt/d0
chown yugabyte.yugabyte /mnt/d0
