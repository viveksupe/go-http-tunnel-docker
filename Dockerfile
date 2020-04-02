FROM golang:alpine AS builder

RUN apk update \
	&& apk add -U git \
	&& apk add ca-certificates \
	&& go get -v github.com/mmatczuk/go-http-tunnel/cmd/... \
	&& rm -rf /var/cache/apk/* 

# final stage
FROM alpine:latest

WORKDIR /home/tunnel

ENV GO_TUNNEL_CLIENTS "B7JVUCO-TZSSVPB-4YG575B-VCCMCHF-LSK7TVR-P5WQVBO-6GYN6VM-VUTZUA5"

COPY docker-entrypoint.sh /home/tunnel/docker-entrypoint.sh
COPY --from=builder /go/bin/tunnel .
COPY --from=builder /go/bin/tunneld .

RUN apk update && apk add openssl \
 	&& apk add ca-certificates \
 	&& rm -rf /var/cache/apk/*
RUN chmod +x tunneld
RUN mkdir .tunneld
WORKDIR /home/tunnel/.tunneld
RUN openssl req -x509 -nodes -newkey rsa:2048 -sha256 -keyout server.key -out server.crt -subj "/C=BO/ST=Bot/L=Bot/O=Bot/CN=bot.com"
CMD ["/home/tunnel/docker-entrypoint.sh"]
