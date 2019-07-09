FROM ubuntu
MAINTAINER MENG YU
ENV REFRESHED_AT 2019-06-21

RUN sed -i s@/archive.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list
RUN apt-get clean

RUN apt-get -yqq update

ENV JAVA_HOME /opt/java/jdk1.8.0_131
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
ENV PATH $PATH:$JAVA_HOME/bin

RUN mkdir -p $JAVA_HOME
ADD jdk-8u131-linux-x64.tar.gz /opt/java

ADD apache-tomcat-9.0.19.tar.gz /opt
RUN ln -s /opt/apache-tomcat-9.0.19 /opt/tomcat9

ENV CATALINA_HOME /opt/tomcat9
ENV CATALINA_BASE /opt/tomcat9
ENV CATALINA_PID /opt/tomcat9.pid
ENV CATALINA_SH /opt/tomcat9/bin/catalina.sh
ENV CATALINA_TMPDIR /tmp/tomcat9-tmp

RUN mkdir -p $CATALINA_TMPDIR
RUN mkdir -p /opt/tomcat9/bin/logs

VOLUME [ "/opt/tomcat9/webapps/" ]

EXPOSE 8080

ENTRYPOINT [ "/opt/tomcat9/bin/catalina.sh" ]
CMD [ "run" ]
