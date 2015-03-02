FROM ximbesto/ximbase:latest
MAINTAINER Ximbesto

RUN apt-get install -y tomcat7 tomcat7-admin

#wget http://192.168.100.222/forgerock/openam12/OpenAM-12.0.0.war

EXPOSE 8080 80 8009 22

CMD ["/sbin/my_init"]
