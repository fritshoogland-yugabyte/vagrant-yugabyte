#!/bin/sh -eux

sudo -u postgres -i sh -c "wget https://github.com/orafce/orafce/archive/refs/tags/VERSION_4_0_0.tar.gz"
sudo -u postgres -i sh -c "tar xzf VERSION_4_0_0.tar.gz"
sudo -u postgres -i sh -c "cd orafce-VERSION_4_0_0; make"
sudo sh -c "cd ~postgres/orafce-VERSION_4_0_0; export PATH=\$PATH:/usr/local/pgsql/bin; make install"
sudo -u postgres -i sh -c "rm VERSION_4_0_0.tar.gz"
sudo -u postgres -i sh -c "psql -c \"create extension orafce;\""
