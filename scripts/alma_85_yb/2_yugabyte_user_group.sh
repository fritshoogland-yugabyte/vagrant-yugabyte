#!/bin/sh -eux

# yugabyte usermanagement.

YUGABYTE_UID=543300
YUGABYTE_GID=543300
#
# check if yugabyte group name and GID exists
# if it does, the script stopts and returns 1
# if it doesn't, the script creates the group
if getent group yugabyte >& /dev/null; then
  echo "groupname: yugabyte already exists"
  exit 1
elif getent group $YUGABYTE_GID >& /dev/null; then
  echo "groupid: $YUGABYTE_GID already exists"
  exit 1
else
  groupadd -g $YUGABYTE_GID yugabyte
fi

#
# check if the yugabyte user name and UID exists 
# if it does, the script stops and returns 1
# if it doesn't, the script creates the user
if getent passwd yugabyte >& /dev/null; then
  echo "username: yugabyte already exists"
  exit 1
elif getent passwd $YUGABYTE_UID >& /dev/null; then
  echo "userid: $YUGABYTE_UID already exists"
  exit 1
else
  useradd -g $YUGABYTE_GID -u $YUGABYTE_UID -m yugabyte
fi

#
usermod -a -G yugabyte vagrant
