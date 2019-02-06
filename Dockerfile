FROM flb-builder-base

ARG FLB_VERSION

ENV FLB_TARBALL https://github.com/fluent/fluent-bit/archive/v$FLB_VERSION.tar.gz

ADD patches /patches

WORKDIR /tmp

# configure flags borrowed from https://github.com/fluent/fluent-bit-packaging/blob/master/distros/centos/7/Dockerfile
RUN curl --location --output "/tmp/fluent-bit-${FLB_VERSION}.tar.gz" ${FLB_TARBALL} && \
    tar xvfz "fluent-bit-$FLB_VERSION.tar.gz"

RUN ([ -f "/patches/${FLB_VERSION}.patch" ] && patch -p1 -d "/tmp/fluent-bit-${FLB_VERSION}" < /patches/${FLB_VERSION}.patch) || \
      echo "no patch file found for ${FLB_VERSION}"

RUN cd "/tmp/fluent-bit-${FLB_VERSION}/build" && \
    cmake3 -DFLB_DEBUG=On -DFLB_TRACE=On -DFLB_TD=On \
           -DFLB_BUFFERING=On -DFLB_SQLDB=On -DFLB_HTTP_SERVER=On \
           -DFLB_OUT_KAFKA=On ../

CMD cd "/tmp/fluent-bit-${FLB_VERSION}/build/" && make && cpack && cp *.rpm /output/
