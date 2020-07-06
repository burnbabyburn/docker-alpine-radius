FROM alpine

RUN apk update && apk upgrade && \
    apk add --update freeradius freeradius-eap freeradius-sqlite freeradius-radclient sqlite && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/*

#VOLUME \
#    /opt/db/ \
#    /etc/freeradius/certs

EXPOSE \
    1812/udp \
    1813/udp \
    18120

CMD ["radiusd","-XX","-f"]
