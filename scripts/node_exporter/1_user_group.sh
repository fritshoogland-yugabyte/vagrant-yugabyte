#!/bin/sh -eux

# node exporter usermanagement.

NODE_EXPORTER_UID=910000
NODE_EXPORTER_GID=910000
#
# check if node_exporter group name and GID exists
# if it does, the script stopts and returns 1
# if it doesn't, the script creates the group
if getent group node_exporter >& /dev/null; then
  echo "groupname: node_exporter already exists"
  exit 1
elif getent group $NODE_EXPORTER_GID >& /dev/null; then
  echo "groupid: $NODE_EXPORTER_GID already exists"
  exit 1
else
  groupadd -g $NODE_EXPORTER_GID node_exporter
fi

#
# check if the node exporter user name and UID exists 
# if it does, the script stops and returns 1
# if it doesn't, the script creates the user
if getent passwd node exporter >& /dev/null; then
  echo "username: node exporter already exists"
  exit 1
elif getent passwd $NODE_EXPORTER_UID >& /dev/null; then
  echo "userid: $NODE_EXPORTER_UID already exists"
  exit 1
else
  useradd -g $NODE_EXPORTER_GID -u $NODE_EXPORTER_UID -m node_exporter
fi

#
usermod -a -G node_exporter vagrant
