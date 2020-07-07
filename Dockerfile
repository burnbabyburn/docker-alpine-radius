FROM alpine

RUN apk update && apk upgrade && \
    apk add --update freeradius freeradius-eap make openssl freeradius-sqlite freeradius-radclient sqlite && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/* && \
    cd /etc/raddb/certs/ && \
    make ca.pem && \
    make ca.der && \
    make server.pem && \
    make client.pem && \
    openssl dhparam -out dh 2048

#VOLUME \
#    /opt/db/ \
#    /etc/freeradius/certs

EXPOSE \
    1812/udp \
    1813/udp \
    18120

COPY /etc /etc/
CMD ["radiusd","-XX","-f"]
