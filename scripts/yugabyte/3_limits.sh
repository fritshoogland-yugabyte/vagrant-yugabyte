#!/bin/sh -eux

echo "# yugabyte user limits
yugabyte                -       core            unlimited
yugabyte                -       data            unlimited
yugabyte                -       fsize           unlimited
yugabyte                -       sigpending      119934
yugabyte	        -       memlock         64
yugabyte                -       rss             unlimited
yugabyte                -       nofile          1048576
yugabyte                -       msgqueue        819200
yugabyte                -       stack           8192
yugabyte                -       cpu             unlimited
yugabyte                -       nproc           12000
yugabyte                -       locks           unlimited
" > /etc/security/limits.d/yugabyte.conf

echo "*          soft    nproc     12000" > /etc/security/limits.d/20-nproc.conf
