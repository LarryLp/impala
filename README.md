# impala
An Apache impala Docker image, which include hive dependences, thus it can query hive tables directly.

pleause follow the steps below to use impala application:

Step 0: modify your hive metadata host info in bash script:/impala/depoly_impala_config.sh
![ABC](https://github.com/LarryLp/impala/blob/2.7/images/hive metadata.png)

Step 1: depoly impala configs
```java  
/impala/depoly_impala_config.sh ${IMPALA_CATALOG_SERVICE_HOST} ${IMPALA_STATE_STORE_HOST}
```
===============================================================================
you can get something like this:
![ABC](https://github.com/LarryLp/impala/blob/2.7/images/depoly_impala_config.png) 


Step 2: start impala service

```java
/// start impala-state-store
sudo service impala-state-store start

/// start impala-catalog
sudo service impala-catalog start

/// start impala-server
sudo service impala-server start
```
