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
[ -z \"$CLIENT\" ] && exit
export CDPATH=$CLIENT:$CDPATH
export PATH=$CLIENT/bin:$CLIENT/tols:$CLIENT/postgres/bin:$PATH" > /usr/local/bin/yb-env
chown yugabyte.yugabyte /usr/local/bin/yb-env
chmod 750 /usr/local/bin/yb-env

chmod -R 750 /opt/yugabyte