FROM         ubuntu:16.04
MAINTAINER    Haria Guo(haria.guo@gmail.com)

#ADD jdk1.8.0_121.tar.gz /opt/
#ADD apache-maven-3.5.0-bin.tar.gz /opt/
#RUN sed -i 's@//archive.ubuntu@//mirrors.aliyun@' /etc/apt/sources.list 

RUN apt-get update && apt-get install -y git wget procps vim net-tools unzip 

WORKDIR /opt

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz
RUN tar zxf jdk-8u121-linux-x64.tar.gz 

RUN wget --no-check-certificate --no-cookies http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
RUN tar zxf apache-maven-3.5.0-bin.tar.gz
RUN rm -rf jdk-8u121-linux-x64.tar.gz apache-maven-3.5.0-bin.tar.gz

ENV JAVA_HOME /opt/jdk1.8.0_121
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:/opt/apache-maven-3.5.0/bin
ENV VERSION 5.3.0

RUN useradd -m -d /home/elk -G root -p elk elk

#RUN apt-get install -y --no-install-recommends python-software-properties software-properties-common
#RUN add-apt-repository -y ppa:webupd8team/java
#RUN apt-get update 
#RUN apt install -y oracle-java8-installer

RUN git clone https://github.com/hariag/elasticsearch-analysis-hanlp.git

WORKDIR /opt/elasticsearch-analysis-hanlp

RUN git checkout 5.x

RUN mvn package

RUN cp /opt/elasticsearch-analysis-hanlp/target/releases/elasticsearch-analysis-plugin-${VERSION}.zip /opt && rm /opt/elasticsearch-analysis-hanlp -rf

WORKDIR /opt/

#RUN wget https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-linux-x86_64.tar.gz
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}.tar.gz
#RUN wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${VERSION}/elasticsearch-analysis-ik-${VERSION}.tar.gz
#RUN wget https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-${VERSION}.zip

WORKDIR /opt/

RUN tar zxf elasticsearch-${VERSION}.tar.gz
#RUN mkdir -p elasticsearch-${VERSION}/plugins/elasticsearch-analysis-ik-${VERSION}
#RUN tar zxf elasticsearch-analysis-ik-${VERSION}.tar.gz -d elasticsearch-${VERSION}/plugins/elasticsearch-analysis-ik-${VERSION}
#RUN echo y|elasticsearch-${VERSION}/bin/elasticsearch-plugin install -s "file://`pwd`/x-pack-${VERSION}.zip"
RUN mkdir -p elasticsearch-${VERSION}/plugins/elasticsearch-analysis-hanlp-${VERSION}
RUN unzip elasticsearch-analysis-plugin-${VERSION}.zip -d elasticsearch-${VERSION}/plugins/elasticsearch-analysis-hanlp-${VERSION}/
#RUN tar zxf kibana-${VERSION}-linux-x86_64.tar.gz
#RUN kibana-${VERSION}-linux-x86_64/bin/kibana-plugin install "file://`pwd`/x-pack-${VERSION}.zip"

ADD /opt/elasticsearch-analysis-hanlp/setup_env.sh /opt/
ADD /opt/elasticsearch-analysis-hanlp/start_master.sh /opt/
#ADD start_node.sh /opt/
#ADD start_kibana.sh /opt/
ADD /opt/elasticsearch-analysis-hanlp/kill_all.sh /opt/
#ADD start_kibana_master.sh /opt/

RUN rm -rf /root/.m2/ /opt/apache-maven-3.5.0 /opt/elasticsearch-analysis-hanlp /opt/elasticsearch-analysis-plugin-5.3.0.zip /opt/x-pack-5.3.0.zip
#RUN bash setup_env.sh elk

RUN chown elk /opt/
RUN chown elk elasticsearch-${VERSION} -R
#RUN chown elk kibana-${VERSION}-linux-x86_64 -R

USER elk

EXPOSE 9200
EXPOSE 9300

WORKDIR /opt/
CMD ["bash", "start_master.sh", ${VERSION}]
