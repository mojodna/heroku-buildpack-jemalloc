FROM heroku/cedar

ENV DEBIAN_FRONTEND noninteractive

ADD src/jemalloc.tar.bz2 /tmp
RUN \
  cd /tmp/jemalloc-* && \
  ./configure --prefix=/app/vendor/jemalloc && \
  make install_bin install_include install_lib_shared install_lib_static && \
  cd /app/vendor/jemalloc && \
  tar zcf /tmp/jemalloc-cedar.tar.gz .
