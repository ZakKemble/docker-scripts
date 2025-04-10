FROM alpine:3.21.3

EXPOSE 5353/udp
EXPOSE 5353/tcp

RUN apk --no-cache add unbound=1.22.0-r0 && rm -rf /var/cache/apk/*

COPY --chmod=755 entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
