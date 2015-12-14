#!/bin/bash

set -e
set -x

echo "[`date`] Starting Installation of nginx"

# $releasever is hardcoded to 7 because it isn't picking up for some reason -- fix this
# $basearch is hardcoded to x86_64 because it isn't picking up either - fix this
cat >> /etc/yum.repos.d/nginx.repo <<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/x86_64/
gpgcheck=0
enabled=1
EOF

yum install -y nginx
