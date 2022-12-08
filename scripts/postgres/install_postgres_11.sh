#!/bin/sh -eux

# preparation
sudo yum -y group install 'Development Tools'
sudo yum -y install readline-devel 

# create postgres user
sudo adduser postgres

# git clone and build postgres
sudo -u postgres -i sh -c "git clone -b REL_11_STABLE https://github.com/postgres/postgres"
sudo -u postgres -i sh -c "cd postgres; ./configure --enable-debug --enable-profiling; make" 

# install postgres on its default location (/usr/local/pgsql)
sudo sh -c "cd ~postgres/postgres; make install"

# create postgres database directory
sudo mkdir /usr/local/pgsql/data
sudo chown postgres.postgres /usr/local/pgsql/data

# init the database
sudo -u postgres -i sh -c "echo '/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/' > /home/postgres/init_postgres.sh"
# start database
sudo -u postgres -i sh -c "echo '/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data/ -l /tmp/postgres.log start &' > /home/postgres/start_postgres.sh"
# stop database
sudo -u postgres -i sh -c "echo '/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data/ stop' > /home/postgres/stop_postgres.sh"

# make scripts executable
sudo -u postgres -i sh -c "chmod 700 /home/postgres/*sh"
# add postgres executables to PATH
sudo -u postgres sh -c "echo 'export PATH=\$PATH:/usr/local/pgsql/bin' >> /home/postgres/.bashrc"
