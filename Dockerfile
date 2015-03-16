FROM tomcat:8.0-jre7
MAINTAINER Reza Mohammadi <reza@cafebazaar.ir>

RUN \
    apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
    echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

RUN \
    apt-get update -q && \
    apt-get upgrade -qy && \
    apt-get install -qy curl unzip nginx supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN \
    rm -r $CATALINA_HOME/webapps/* && \
    curl http://download.forgerock.org/downloads/openam/openam_link.js | grep -o "http://.*\.war" | xargs curl -o $CATALINA_HOME/webapps/openam.war

CMD /usr/bin/IAM-initializer
EXPOSE 80 443 389 636
VOLUME ["/var/logs/IAM", "/var/IAM/", "/opt/opendj/locks"]

ADD assets/OpenDJ-2.6.0.zip                 /tmp/OpenDJ-2.6.0.zip
RUN \
    unzip /tmp/OpenDJ-2.6.0.zip -d /opt/ && \
    rm /tmp/OpenDJ-2.6.0.zip

ADD assets/supervisord.conf                 /etc/supervisor/supervisord.conf
ADD assets/opendj_through_supervisord.sh    /usr/bin/opendj_through_supervisord.sh
ADD assets/nginx.conf                       /etc/nginx/nginx.conf
ADD assets/cts-add-schema.ldif              /tmp/cts-add-schema.ldif
ADD assets/IAM-initializer                  /usr/bin/IAM-initializer
