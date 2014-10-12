FROM mojodna/cedar-14-stack

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get upgrade -y

ADD ./jemalloc.tar.bz2 /tmp
RUN \
  cd /tmp/jemalloc-* && \
  ./configure --prefix=/app/vendor/jemalloc && \
  make install_bin install_include install_lib_shared install_lib_static && \
  cd /app/vendor/jemalloc && \
  tar zcf /tmp/jemalloc-cedar-14.tar.gz .

