FROM ubuntu:10.04

ENV DEBIAN_FRONTEND noninteractive

# Initialize cedar stack
ADD ./cedar.sh /tmp/cedar.sh
RUN \
  /bin/bash /tmp/cedar.sh

RUN \
  apt-get upgrade -y
