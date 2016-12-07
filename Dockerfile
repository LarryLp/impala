FROM parana/centos7

# Based on centos:7.2.1511 Public Image

MAINTAINER "larry king" <jiangguoqing@starts.org.cn>`

# set cloudera repository
RUN echo -e "# Packages for Cloudera's Distribution for Hadoop, Version 5, on RedHat or CentOS 7 x86_64\n[cloudera-cdh5]\nname=Cloudera's Distribution for Hadoop, Version 5\nbaseurl=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/\ngpgkey =https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera\ngpgcheck = 1" > /etc/yum.repos.d/cloudera.repo
RUN yum update & \
    yum install -y vim & \
    yum install -y net-tools

# install jdk1.8
RUN yum install -y java-1.8.0-openjdk

# install latest version of impala
RUN yum install -y impala impala-server impala-state-store impala-catalog impala-shell

# set JAVA_HOME 
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64" >> /etc/default/bigtop-utils


CMD [ "/bin/bash" ]
