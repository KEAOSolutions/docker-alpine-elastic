FROM ukhomeoffice/openjre8:latest

ARG ELASTIC_VERSION=2.3.1
ENV ELASTIC_VERSION $ELASTIC_VERSION

ARG ELASTIC_DOWNLOAD_URL=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ELASTIC_VERSION/elasticsearch-$ELASTIC_VERSION.tar.gz
ENV ELASTIC_DOWNLOAD_URL $ELASTIC_DOWNLOAD_URL
ENV ELASTIC_HOME=/usr/share/elasticsearch

RUN apk add --update curl
RUN curl -s ${ELASTIC_DOWNLOAD_URL} | tar zx -C /usr/share && \
    ln -s /usr/share/elasticsearch-${ELASTIC_VERSION} $ELASTIC_HOME && \
    mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs /usr/share/elasticsearch/plugins && \
    adduser -DH -s /sbin/nologin elasticsearch && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch
COPY config /usr/share/elasticsearch/config
RUN apk del curl && \
    rm -rf /var/cache/apk/*

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

VOLUME /usr/share/elasticsearch/data

#COPY config ./config
COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
