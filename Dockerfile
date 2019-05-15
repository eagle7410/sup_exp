FROM node:carbon-jessie
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update &&\
    apt-get install -y supervisor &&\
	mkdir -p /var/log/supervisor &&\
	mkdir -p /usr/app/
RUN apt-get install -y python-pip && pip2 install supervisor-stdout
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
WORKDIR /usr/app/
ADD . .
ENTRYPOINT /usr/bin/supervisord
