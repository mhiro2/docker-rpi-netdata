FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER mhiro2 <hirotsu.masaaki@gmail.com>

ENV PORT 19999

RUN apk add --no-cache bash curl libmnl-dev python logrotate libuuid \
  && apk add --no-cache --virtual build-dependencies alpine-sdk zlib-dev util-linux-dev gcc make git autoconf automake pkgconfig \
  && git clone https://github.com/firehol/netdata.git --depth=1 /tmp/netdata \
  && cd /tmp/netdata \
  && ./netdata-installer.sh --dont-start-it \
  && apk del --purge build-dependencies \
  && rm -rf /tmp/*

EXPOSE ${PORT}

ENTRYPOINT ["/usr/sbin/netdata"]
CMD ["-D", "-p", "${PORT}"]
