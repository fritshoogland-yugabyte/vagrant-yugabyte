#!/bin/sh -eux

echo "# yugabyte user limits
yb                -       core            unlimited
yb                -       data            unlimited
yb                -       fsize           unlimited
yb                -       sigpending      119934
yb		  -       memlock         64
yb                -       rss             unlimited
yb                -       nofile          1048576
yb                -       msgqueue        819200
yb                -       stack           8192
yb                -       cpu             unlimited
yb                -       nproc           12000
yb                -       locks           unlimited
" > /etc/security/limits.d/yugabyte.conf

echo "*          soft    nproc     12000" > /etc/security/limits.d/20-nproc.conf
