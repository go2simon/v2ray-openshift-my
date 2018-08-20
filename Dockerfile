FROM alpine:3.7

ENV CONFIG_JSON=none CERT_PEM=none KEY_PEM=none VER=3.25

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /mybin \ 
 && cd /mybin \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip v2ray.zip \
 && mv /mybin/v2ray-v$VER-linux-64/v2ray /mybin/cgi \
 && mv /mybin/v2ray-v$VER-linux-64/v2ctl /mybin/ \
 && mv /mybin/v2ray-v$VER-linux-64/geoip.dat /mybin/ \
 && mv /mybin/v2ray-v$VER-linux-64/geosite.dat /mybin/ \
 && chmod +x /mybin/cgi \
 && rm -rf v2ray.zip \
 && rm -rf v2ray-v$VER-linux-64 \
 && chgrp -R 0 /mybin \
 && chmod -R g+rwX /mybin 
 
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
