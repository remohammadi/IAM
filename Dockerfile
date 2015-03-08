FROM ximbesto/ximbase:latest
MAINTAINER Ximbesto

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y default-jdk tomcat7 tomcat7-admin

RUN mv /var/lib/tomcat7/webapps/ROOT/ /var/lib/tomcat7/webapps/ROOT1/
RUN curl http://download.forgerock.org/downloads/openam/openam_link.js | grep -o "http://.*\.war" | xargs curl -o /var/lib/tomcat7/webapps/ROOT.war

# setup httpd
RUN apt-get install -y apache2
RUN a2enmod ssl
ADD openam-proxy.conf /etc/httpd/conf.d/openam-proxy.conf

EXPOSE 22 80 443 8080 8009

RUN mkdir /usr/share/tomcat7/config

# run tomcat
#CMD ["/sbin/my_init"]
#RUN chown -R tomcat7:tomcat7 /usr/share/tomcat7/config
#USER tomcat7
#VOLUME /usr/share/tomcat7/config

ADD assets/start /app/start
RUN chmod 755 /app/start

ENTRYPOINT ["/app/start"]
CMD /etc/init.d/tomcat7 start && wait && /etc/init.d/apache2 start && wait && tail -f /var/log/tomcat7/catalina.out
