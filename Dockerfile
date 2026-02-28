FROM debian:latest

COPY entrypoint.sh /

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y  procps \
    nginx-full nginx-extras libnginx-mod-http-dav-ext libnginx-mod-http-auth-pam  openssl \
    && apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/* \
    && rm /etc/nginx/sites-enabled/* \
    && mkdir -p "/media/data" \
    && chmod +x entrypoint.sh


COPY webdav.conf /etc/nginx/conf.d/default.conf

#RUN chown -R www-data:www-data "/media/data"

VOLUME /media/data

USER  root
CMD /entrypoint.sh && nginx -g "daemon off;"
