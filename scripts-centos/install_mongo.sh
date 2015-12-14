#!/bin/bash

set -e
set -x

echo "[`date`] Starting Installation of mongo"

# $releasever is hardcoded to 7 because it isn't picking up for some reason -- fix this
cat >> /etc/yum.repos.d/mongodb-org-3.0.repo <<EOF
[mongodb-org-3.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.0/x86_64/
gpgcheck=0
enabled=1
EOF

yum install -y mongodb-org
