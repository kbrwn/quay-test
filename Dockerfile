FROM java:openjdk-8-jre

ARG solr_version=7.2.1
ENV SOLR_USER="solr" \
    SOLR_UID="431" \
    SOLR_GROUP="solr" \
    SOLR_GID="433" \
    SOLR_VERSION=$solr_version \
    SOLR_HOME=/opt/solr \
    PATH="/opt/solr/bin:$PATH"
    
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get -y install lsof \
  && groupadd -r -g $SOLR_GID $SOLR_GROUP \
  && useradd -r -u $SOLR_UID -g $SOLR_GROUP $SOLR_USER

COPY ./setup_solr.sh /tmp

RUN wget "http://archive.apache.org/dist/lucene/solr/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz" -P /tmp \
 && chmod a+x /tmp/solr*.tgz \
 && tar xfz /tmp/solr-${SOLR_VERSION}.tgz -C /opt \
 && mv /opt/solr-${SOLR_VERSION} /opt/solr \
 && mkdir -p /opt/data \
 && cp /opt/solr/example/resources/log4j.properties /opt/solr/log4j.properties \
 && mkdir -p /opt/logs \
 && rm /tmp/solr-*.tgz \
 && mv /tmp/setup_solr.sh /opt/solr/bin \
# && mv /tmp/conf /opt \
 && chmod a+x /opt/solr/bin/setup_solr.sh \
 && sed -i -e 's/"\$(whoami)" == "root"/$(id -u) == 0/' /opt/solr/bin/solr \
 && sed -i -e 's/lsof -PniTCP:/lsof -t -PniTCP:/' /opt/solr/bin/solr \
 && sed -i -e '/-Dsolr.clustering.enabled=true/ a SOLR_OPTS="$SOLR_OPTS -Dsun.net.inetaddr.ttl=60 -Dsun.net.inetaddr.negative.ttl=60"' /opt/solr/bin/solr.in.sh \
 && chown -R $SOLR_USER:$SOLR_GROUP /opt/solr \
# && chown -R $SOLR_USER:$SOLR_GROUP /opt/conf \
 && chown -R $SOLR_USER:$SOLR_GROUP /opt/data \
 && chown -R $SOLR_USER:$SOLR_GROUP /opt/logs \ 
 && chmod -R 777 /opt/solr \
 && chmod -R 777 /opt/data \
# && chmod -R 777 /opt/conf \
 && chmod -R 777 /opt/logs \  
 && ls -l /opt/solr \
 && ls -l /opt/data \
 && ls -l /opt/solr/bin \
# && ls -l /opt/conf \
 && echo $PATH
 
RUN apt-get --assume-yes install vim
 
EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER 

VOLUME ["/solr"]

ENTRYPOINT ["/opt/solr/bin/setup_solr.sh"]
