#!/bin/sh -eux

sudo -u postgres -i sh -c "git clone -b PG13 https://github.com/ossc-db/pg_hint_plan.git"
sudo -u postgres -i sh -c "cd pg_hint_plan; make"
sudo sh -c "cd ~postgres/pg_hint_plan; export PATH=\$PATH:/usr/local/pgsql/bin; make install"