# below are general purpose OL versions
# packer fix: packer fix current.json > new.json
#
# plain centos 8.3
#packer build -on-error=ask centos_83.json
# centos 8.3 - yugabyte 
packer build -on-error=ask centos_83_yb.json
