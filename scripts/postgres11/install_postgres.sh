#!/bin/sh -eux

sudo yum -y group install 'Development Tools'
sudo yum -y install readline-devel 
git clone -b REL_11_STABLE https://github.com/postgres/postgres
cd postgres
./configure --enable-debug --enable-profiling 
make
sudo make install
sudo adduser postgres
sudo mkdir /usr/local/pgsql/data
sudo chown postgres.postgres /usr/local/pgsql/data
sudo -u postgres /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/

sudo -u postgres sh -c "echo '/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data/ -l /tmp/postgres.log start &' > /home/postgres/start_postgres.sh"
sudo -u postgres sh -c "echo '/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data/ stop' > /home/postgres/stop_postgres.sh"
sudo -u postgres sh -c "chmod 700 /home/postgres/*sh"
sudo -u postgres sh -c "echo 'export PATH = $PATH:/usr/local/pgsql/bin' > /home/postgres/.bashrc"
