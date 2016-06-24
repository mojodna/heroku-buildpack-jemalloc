FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# Initialize cedar-14 stack
ADD ./cedar-14.sh /tmp/cedar-14.sh
RUN \
  /bin/bash /tmp/cedar-14.sh

RUN \
  apt-get upgrade -y
