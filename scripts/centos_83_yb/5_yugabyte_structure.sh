#!/bin/sh -eux

mkdir -p /opt/yugabyte/conf
chown -R yugabyte.yugabyte /opt/yugabyte

# empty home.environment file
echo "# this is an environment file
# used by the tserver and master systemd unit files
# and the yb-env utility
TSERVER=\"\"
MASTER=\"\"
CLIENT=\"\"" > /opt/yugabyte/conf/home.environment

# yb-env
echo "#!/bin/bash
source /opt/yugabyte/conf/home.environment
if [ ! -z \"\$CLIENT\" ]; then
export CDPATH=\$CLIENT:\$CDPATH
export PATH=\$CLIENT/bin:\$CLIENT/tools:\$CLIENT/postgres/bin:\$PATH
fi" > /usr/local/bin/yb-env
chown yugabyte.yugabyte /usr/local/bin/yb-env
chmod 750 /usr/local/bin/yb-env

chown -R yugabyte.yugabyte /opt/yugabyte
chmod -R 750 /opt/yugabyte