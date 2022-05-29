#!/bin/sh -eux


#YUGABYTE_NUMERIC_VERSION=$1
#YUGABYTE_BUILD=$2
#YUGABYTE_NUMERIC_VERSION=2.13.0.1
#YUGABYTE_VERSION=yugabyte-$YUGABYTE_NUMERIC_VERSION-b2
#
# YUGABYTE_NUMERIC_VERSION and YUGABYTE_BUILD are set as environment variables by the provisioner.
#
YUGABYTE_VERSION=yugabyte-${YUGABYTE_NUMERIC_VERSION}-${YUGABYTE_BUILD}
YUGABYTE_DIRECTORY=yugabyte-$YUGABYTE_NUMERIC_VERSION

echo "download software"
wget -q https://downloads.yugabyte.com/releases/$YUGABYTE_NUMERIC_VERSION/$YUGABYTE_VERSION-linux-x86_64.tar.gz -O /tmp/$YUGABYTE_VERSION-linux-x86_64.tar.gz
echo "untar software"
tar xzf /tmp/$YUGABYTE_VERSION-linux-x86_64.tar.gz -C /opt/yugabyte
echo "remove tarball"
rm /tmp/$YUGABYTE_VERSION-linux-x86_64.tar.gz
echo "change ownership"
chown -R yugabyte.yugabyte /opt/yugabyte/$YUGABYTE_DIRECTORY
echo "run post_install.sh"
su -c "cd /opt/yugabyte/$YUGABYTE_DIRECTORY; ./bin/post_install.sh" yugabyte

echo "set tserver, master and client to $YUGABYTE_NUMERIC_VERSION"
sed -i "s/\(TSERVER=\"\)\(\"\)/\1$YUGABYTE_DIRECTORY\2/" /opt/yugabyte/conf/home.environment
sed -i "s/\(MASTER=\"\)\(\"\)/\1$YUGABYTE_DIRECTORY\2/" /opt/yugabyte/conf/home.environment
sed -i "s/\(CLIENT=\"\)\(\"\)/\1$YUGABYTE_DIRECTORY\2/" /opt/yugabyte/conf/home.environment
