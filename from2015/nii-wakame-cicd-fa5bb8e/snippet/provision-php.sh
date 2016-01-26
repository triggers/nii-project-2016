#!/bin/bash
#
# requires:
#  bash
#  mysqladmin, mysql
#
set -e
set -o pipefail
set -x

if [[ -f /metadata/user-data ]]; then
  . /metadata/user-data
fi
: "${DB_HOST:?"should not be empty"}"

cd /tmp

until curl -fsSkL -O http://wordpress.org/latest.tar.gz; do
  sleep 1
done
tar zxf latest.tar.gz
rsync -ax wordpress/ /var/www/html/

cd /var/www/html
cp -p wp-config-sample.php wp-config.php

sed -i \
 -e s,database_name_here,wordpress, \
 -e s,username_here,wordpressuser,  \
 -e s,password_here,password, \
 -e s,localhost,${DB_HOST}, \
 wp-config.php

# dbhost
# sed -i -e s,localhost,10.0.22.101, wp-config.php

diff wp-config-sample.php wp-config.php || :

service httpd restart
