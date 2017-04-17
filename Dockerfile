FROM         ubuntu:16.04
MAINTAINER    Haria Guo(haria.guo@gmail.com)

ADD jdk1.8.0_121.tar.gz /opt/
ADD apache-maven-3.5.0-bin.tar.gz /opt/

ENV JAVA_HOME /opt/jdk1.8.0_121
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:/opt/apache-maven-3.5.0/bin

RUN apt-get update && apt-get install -y \
  git \
  wget

WORKDIR /opt

RUN git clone https://github.com/hariag/elasticsearch-analysis-hanlp.git

WORKDIR /opt/elasticsearch-analysis-hanlp

RUN git checkout 5.x

RUN mvn package

WORKDIR /opt/
