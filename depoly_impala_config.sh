#!/usr/bin/env bash

if [ $# -eq 2 ]; then
  # add metadata info,you should modify it according to your own situation 
  echo "192.168.0.91 node01" >> /etc/hosts
  
  # set service ip 
  echo 'IMPALA_CATALOG_SERVICE_HOST='$1''> /etc/default/impala
  echo 'IMPALA_STATE_STORE_HOST='$2'' >> /etc/default/impala

  # add impala config
  cat /etc/default/config.txt|col -b >> /etc/default/impala
  echo "impala config job done!"
else 
  echo "Invalid command number"
  exit 1
fi

