FROM alpine:3.21.3

EXPOSE 67/udp

RUN apk --no-cache add dhcp-helper=1.2-r3 && rm -rf /var/cache/apk/*

ENTRYPOINT ["dhcp-helper", "-n"]
