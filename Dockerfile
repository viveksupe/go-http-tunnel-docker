FROM ubuntu:latest

WORKDIR /home/tunnel

ENV GO_TUNNEL_VER 2.1
ENV GO_TUNNEL_CLIENTS "B7JVUCO-TZSSVPB-4YG575B-VCCMCHF-LSK7TVR-P5WQVBO-6GYN6VM-VUTZUA5"

COPY docker-entrypoint.sh /home/tunnel/docker-entrypoint.sh

RUN apt-get update -y
RUN apt-get install wget -y
RUN wget https://github.com/mmatczuk/go-http-tunnel/releases/download/$GO_TUNNEL_VER/tunnel_linux_amd64.tar.gz
RUN tar xvf tunnel_linux_amd64.tar.gz
RUN chmod +x tunneld
RUN mkdir .tunneld
WORKDIR /home/tunnel/.tunneld
RUN openssl req -x509 -nodes -newkey rsa:2048 -sha256 -keyout server.key -out server.crt -subj "/C=BO/ST=Bot/L=Bot/O=Bot/CN=bot.com"
CMD ["/home/tunnel/docker-entrypoint.sh"]
