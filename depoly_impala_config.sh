#!/usr/bin/env bash


# add metadata info,you should modify it according to your own situation 
RUN echo "192.168.0.91 node01" >> /etc/hosts

# set container ip address
echo 'IMPALA_CATALOG_SERVICE_HOST='$(hostname -I|awk '{print $1}') > /etc/default/impala
echo 'IMPALA_STATE_STORE_HOST='$(hostname -I|awk '{print $1}') >> /etc/default/impala

# add impala config
cat /etc/default/config.txt|col -b >> /etc/default/impala

echo "impala config job done!"
