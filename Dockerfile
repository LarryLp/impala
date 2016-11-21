FROM singularities/hadoop:2.7
MAINTAINER Singularities

# Version
ENV SPARK_VERSION=1.6.3

# Set home
ENV SPARK_HOME=/usr/local/spark-$SPARK_VERSION

# Install dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install \
    -yq --no-install-recommends  \
      python python3 \
  && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install Spark
RUN mkdir -p "${SPARK_HOME}" \
  && export ARCHIVE=spark-$SPARK_VERSION-bin-without-hadoop.tgz \
  && export DOWNLOAD_PATH=apache/spark/spark-$SPARK_VERSION/$ARCHIVE \
  && curl -sSL https://mirrors.ocf.berkeley.edu/$DOWNLOAD_PATH | \
    tar -xz -C $SPARK_HOME --strip-components 1 \
  && rm -rf $ARCHIVE
COPY spark-env.sh $SPARK_HOME/conf/spark-env.sh
ENV PATH=$PATH:$SPARK_HOME/bin

# delete duplicate jars
#RUN rm $SPARK_HOME/lib/spark-assembly*jar

# add hdp & hive dependences
#ENV REPO_ADDR=http://192.168.0.91/jars
#RUN wget -r -nd --accept=jar $REPO_ADDR/spark1.6/ $SPARK_HOME/lib
 
# add hive confs
COPY hive-site.xml $SPARK_HOME/conf/hive-site.xml

# add hive assembly jars
COPY datanucleus-api-jdo-3.2.6.jar $SPARK_HOME/lib/datanucleus-api-jdo-3.2.6.jar
COPY datanucleus-core-3.2.10.jar $SPARK_HOME/lib/datanucleus-core-3.2.10.jar
COPY datanucleus-rdbms-3.2.9.jar $SPARK_HOME/lib/datanucleus-rdbms-3.2.9.jar

# add ip map
RUN echo "192.168.0.91 node01" >> /etc/hosts

# ports
EXPOSE 4040 6066 7077 8080 8081

# Copy start script
COPY start-spark /opt/util/bin/start-spark

# Fix environment for other users
RUN echo "export SPARK_HOME=$SPARK_HOME" >> /etc/bash.bashrc \
  && echo 'export PATH=$PATH:$SPARK_HOME/bin'>> /etc/bash.bashrc

# Add deprecated commands
RUN echo '#!/usr/bin/env bash' > /usr/bin/master \
  && echo 'start-spark master' >> /usr/bin/master \
  && chmod +x /usr/bin/master \
  && echo '#!/usr/bin/env bash' > /usr/bin/worker \
  && echo 'start-spark worker $1' >> /usr/bin/worker \
  && chmod +x /usr/bin/worker
