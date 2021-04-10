#!/bin/sh -eux

groupadd -g 5433 yb
useradd -g 5433 -u 5433 -m yb
echo "yb:yb" | chpasswd

echo "%yb ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/yb
