#!/bin/bash

set -e
set -x

cd /tmp
wget https://github.com/threatstream/hpfeeds/releases/download/libev-4.15/libev-4.15.tar.gz
tar zxvf libev-4.15.tar.gz
cd libev-4.15
./configure && make && make install
ldconfig

cd /opt
git clone https://github.com/threatstream/hpfeeds
chmod 755 -R hpfeeds
cd hpfeeds
virtualenv env
. env/bin/activate

pip install -e git+https://github.com/rep/evnet.git#egg=evnet-dev
pip install .

mkdir -p /var/log/mhn

cat >> /etc/supervisor/conf.d/hpfeeds-broker.conf <<EOF
[program:hpfeeds-broker]
command=/opt/hpfeeds/env/bin/python /opt/hpfeeds/broker/feedbroker.py
directory=/opt/hpfeeds
stdout_logfile=/var/log/mhn/hpfeeds-broker.log
stderr_logfile=/var/log/mhn/hpfeeds-broker.err
autostart=true
autorestart=true
startsecs=10
EOF

supervisorctl update
