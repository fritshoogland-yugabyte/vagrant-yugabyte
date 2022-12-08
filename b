# below are general purpose OL versions
# packer fix: packer fix current.json > new.json
#
# plain centos 8.3
#packer build -on-error=ask centos_83.json
# centos 8.3 - postgres 11
#packer build -on-error=ask centos_83_pg_11.json
# centos 8.3 - yugabyte 
#packer build -on-error=ask centos_83_yb.json
# centos 8.4 - yugabyte 
#packer build -on-error=ask centos_84_yb.json
# rocky 8.4 - yugabyte
#packer build -on-error=ask rocky_84_yb.json
# alma 8.4 - yugabyte
#packer build -on-error=ask alma_84_yb.json
# alma 8.5
#packer build -on-error=ask alma_85.json
# alma 8.6
#packer build -on-error=ask alma_86.json
# alma 8.6 - postgres 11
#packer build -on-error=ask alma_86_postgres_11.json
packer build -on-error=ask alma_87_postgres_13.json
# alma 8.5 - yugabyte
#packer build -on-error=ask alma_85_yb.json
# alma 8.6 - yugabyte
#packer build -on-error=ask alma_86_yb.json
# alma 8.7 - yugabyte
#packer build -on-error=ask alma_87_yb.json
# alma 9.0 - yugabyte
#packer build -on-error=ask alma_90_yb.json
# alma 9.1 - yugabyte
#packer build -on-error=ask alma_91_yb.json
