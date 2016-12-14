# impala
This is An Apache impala Docker image , which is latest version, include hive dependences, thus it can query hive tables directly.

pleause follow the steps below to use impala application:

Step 0: modify your hive metadata host info in bash script:/impala/depoly_impala_config.sh
![ABC](https://github.com/LarryLp/impala/blob/2.7/images/hive metadata.png)

ATTENTION: ip address in statement echo "192.168.0.91 node01" >> /etc/hosts should be adjusted!

========================================================================================
Step 1: depoly impala configs
```java  
/impala/depoly_impala_config.sh ${IMPALA_CATALOG_SERVICE_HOST} ${IMPALA_STATE_STORE_HOST}
```

you can get something like this:
![ABC](https://github.com/LarryLp/impala/blob/2.7/images/depoly_impala_config.png) 

========================================================================================
Step 2: start impala service

```java
/// start impala-state-store
sudo service impala-state-store start

/// start impala-catalog
sudo service impala-catalog start

/// start impala-server
sudo service impala-server start
```
========================================================================================
Step 3: you can use impala latest
![ABC](https://github.com/LarryLp/impala/blob/2.7/images/impala catalog.png)

![ABC](https://github.com/LarryLp/impala/blob/2.7/images/impala backend.png)

also impala shell:

![ABC](https://github.com/LarryLp/impala/blob/2.7/images/impala shell.png)
