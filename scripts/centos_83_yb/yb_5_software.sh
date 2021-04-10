#!/bin/sh -eux

echo "download software"
wget -q https://downloads.yugabyte.com/yugabyte-2.5.3.1-linux.tar.gz -O /tmp/yugabyte-2.5.3.1-linux.tar.gz
echo "untar software"
tar xzf /tmp/yugabyte-2.5.3.1-linux.tar.gz -C /opt
echo "remove tarball"
rm /tmp/yugabyte-2.5.3.1-linux.tar.gz
echo "change ownership"
chown -R yb.yb /opt/yugabyte-2.5.3.1
echo "run post_install.sh"
su -c "cd /opt/yugabyte-2.5.3.1; ./bin/post_install.sh" yb
echo "change profile to include path"
echo "export YB_PATH=/opt/yugabyte-2.5.3.1
export PATH=\$PATH:\$YB_PATH/bin" >> /home/yb/.bash_profile

echo "create yb-master flagfile"
su -c "echo \"--master_addresses=127.0.0.1:7100
--rpc_bind_addresses=0.0.0.0
--fs_data_dirs=/mnt/disk1
--placement_cloud=local
--placement_region=local
--placement_zone=local
--replication_factor=1\" > /home/yb/master.conf" yb

echo "create yb-master unit file"
echo "[Unit]
Description=Yugabyte master service
Requires=network-online.target
After=network.target network-online.target multi-user.target

[Service]
User=yb
Group=yb
LimitSIGPENDING=119934
LimitNOFILE=1048576
LimitNPROC=12000
ExecStart=/opt/yugabyte-2.5.3.1/bin/yb-master --flagfile /home/yb/master.conf
ExecStop=/bin/kill -s HUP \$MAINPID
Restart=on-failure
RestartSec=3s
KillSignal=SIGKILL
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=default.target" > /etc/systemd/system/yb-master.service

echo "create yb-tserver flagfile"
su -c "echo \"--tserver_master_addrs=127.0.0.1:7100
--rpc_bind_addresses=0.0.0.0
--start_pgsql_proxy
--pgsql_proxy_bind_address=0.0.0.0:5433
--cql_proxy_bind_address=0.0.0.0:9042
--fs_data_dirs=/mnt/disk1
--placement_cloud=local
--placement_region=local
--placement_zone=local\" > /home/yb/tserver.conf" yb

echo "create yb-tserver unit file"
echo "[Unit]
Description=Yugabyte tserver service
Requires=network-online.target
After=network.target network-online.target multi-user.target

[Service]
User=yb
Group=yb
LimitSIGPENDING=119934
LimitNOFILE=1048576
LimitNPROC=12000
ExecStart=/opt/yugabyte-2.5.3.1/bin/yb-tserver --flagfile /home/yb/tserver.conf
ExecStop=/bin/kill -s HUP \$MAINPID
Restart=on-failure
RestartSec=3s
KillSignal=SIGKILL
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=default.target" > /etc/systemd/system/yb-tserver.service

echo "create fake mountpoint for database files"
mkdir /mnt/disk1
chown yb.yb /mnt/disk1
