FROM centos

# Based on centos:7.2.1511 Public Image

MAINTAINER "larry king" <jiangguoqing@starts.org.cn>`

# set cloudera repository
RUN echo -e "# Packages for Cloudera's Distribution for Hadoop, Version 5, on RedHat or CentOS 7 x86_64\n[cloudera-cdh5]\nname=Cloudera's Distribution for Hadoop, Version 5\nbaseurl=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/\ngpgkey =https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera\ngpgcheck = 1" > /etc/yum.repos.d/cloudera.repo

# install jdk1.8
RUN yum install -y java-1.8.0-openjdk

# install latest version of impala
RUN yum install -y impala impala-server impala-state-store impala-catalog impala-shell

# set JAVA_HOME 
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64" >> /etc/default/bigtop-utils

# add hadoop hive configure
COPY config/core-site.xml /etc/impala/conf/core-site.xml
COPY config/hive-site.xml /etc/impala/conf/hive-site.xml
COPY config/hdfs-site.xml /etc/impala/conf/hdfs-site.xml

# add mysql-connector-jar
COPY mysql-connector-jar/mysql-connector-java.jar /usr/share/java/mysql-connector-java.jar


# add metadata info,you should modify it according to your own situation 
RUN echo "192.168.0.91 node01" >> /etc/hosts

# set container ip address
RUN echo 'IMPALA_CATALOG_SERVICE_HOST='$(hostname -I|awk '{print $1}')|col -b > /etc/default/impala
RUN echo 'IMPALA_STATE_STORE_HOST='$(hostname -I|awk '{print $1}')|col -b >> /etc/default/impala

# add impala config
COPY config/impala /etc/default/config.txt
RUN cat /etc/default/config.txt >> /etc/default/impala && \
    rm -rf /etc/default/config.txt

CMD [ "/bin/bash" ]
