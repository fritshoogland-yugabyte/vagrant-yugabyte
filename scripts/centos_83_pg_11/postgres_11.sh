#!/bin/sh -eux

# 1. install postgres yum repo
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# 2. disable postgresql module
yum -y module disable postgresql

# 3. clean cache
yum clean all

# 4. install postgresql 11 
yum -y install postgresql11-server postgresql11

# 5. initialize database
/usr/pgsql-11/bin/postgresql-11-setup initdb

# 6. enable and start postgresql-11 unit
systemctl enable --now postgresql-11
