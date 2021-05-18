#!/bin/sh -eux

YUGABYTE_VERSION=yugabyte-2.7.0.0

echo "download software"
wget -q https://downloads.yugabyte.com/$YUGABYTE_VERSION-linux.tar.gz -O /tmp/$YUGABYTE_VERSION-linux.tar.gz
echo "untar software"
tar xzf /tmp/$YUGABYTE_VERSION-linux.tar.gz -C /opt/yugabyte
echo "remove tarball"
rm /tmp/$YUGABYTE_VERSION-linux.tar.gz
echo "change ownership"
chown -R yugabyte.yugabyte /opt/$YUGABYTE_VERSION
echo "run post_install.sh"
su -c "cd /opt/$YUGABYTE_VERSION; ./bin/post_install.sh" yugabyte

echo "set tserver, master and client to $YUGABYTE_VERSION"
sed -i "s/\(TSERVER=\"\)\(\"\)/\1$YUGABYTE_VERSION\2/" /opt/yugabyte/conf/home.environment
sed -i "s/\(MASTER=\"\)\(\"\)/\1$YUGABYTE_VERSION\2/" /opt/yugabyte/conf/home.environment
sed -i "s/\(CLIENT=\"\)\(\"\)/\1$YUGABYTE_VERSION\2/" /opt/yugabyte/conf/home.environment