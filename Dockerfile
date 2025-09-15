FROM debian:13-slim

LABEL maintainer="maltokyo"

RUN apt-get update && apt-get install -y nginx nginx-extras apache2-utils


COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

VOLUME /media/data

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
CMD /entrypoint.sh && nginx -g "daemon off;"
