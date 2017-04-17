FROM         ubuntu:16.04
MAINTAINER    Haria Guo(haria.guo@gmail.com)

#ADD jdk1.8.0_121.tar.gz /opt/
#ADD apache-maven-3.5.0-bin.tar.gz /opt/

RUN apt-get update && apt-get install -y git wget

WORKDIR /opt

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz

RUN tar zxf jdk-8u121-linux-x64.tar.gz 
RUN wget --no-check-certificate --no-cookies http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
RUN tar zxf apache-maven-3.5.0-bin.tar.gz
RUN rm -rf jdk-8u121-linux-x64.tar.gz apache-maven-3.5.0-bin.tar.gz

ENV JAVA_HOME /opt/jdk1.8.0_121
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:/opt/apache-maven-3.5.0/bin


#RUN apt-get install -y --no-install-recommends python-software-properties software-properties-common
#RUN add-apt-repository -y ppa:webupd8team/java
#RUN apt-get update 
#RUN apt install -y oracle-java8-installer

RUN git clone https://github.com/hariag/elasticsearch-analysis-hanlp.git

WORKDIR /opt/elasticsearch-analysis-hanlp

RUN git checkout 5.x

RUN mvn package

WORKDIR /opt/
