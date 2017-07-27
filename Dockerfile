# Based on Scala and sbt Dockerfile
# https://github.com/hseeberger/scala-sbt
# Not directly used because we need Scala 2.11

FROM biggis/base:java8-jre-alpine

MAINTAINER JochenLutz

ARG SCALA_VERSION=2.11.8
ENV SCALA_SHORTVERSION=2.11
ENV SBT_VERSION 0.13.9
ENV CODEKUNSTMQTT_VERSION=3.1
ENV TARGET=/opt/codekunst-mqtt

ARG BUILD_DATE
ARG VCS_REF

LABEL eu.biggis-project.build-date=$BUILD_DATE \
      eu.biggis-project.license="MIT" \
      eu.biggis-project.name="BigGIS" \
      eu.biggis-project.url="http://biggis-project.eu/" \
      eu.biggis-project.vcs-ref=$VCS_REF \
      eu.biggis-project.vcs-type="Git" \
      eu.biggis-project.vcs-url="https://github.com/biggis-project/sensebox-station/CodekunstMQTTAdapter" \
      eu.biggis-project.environment="dev" \
      eu.biggis-project.version=$CODEKUNSTMQTT_VERSION

# Define working directory
WORKDIR $TARGET

# Install curl
RUN \
  set -x && \
  apk --update add --virtual build-dependencies coreutils curl && \
  curl -L -O https://github.com/biggis-project/sensebox-station/releases/download/Codekunst-MQTT-v$CODEKUNSTMQTT_VERSION/CodekunstMQTTAdapter-assembly-${CODEKUNSTMQTT_VERSION}.jar && \
    unzip CodekunstMQTTAdapter-assembly-${CODEKUNSTMQTT_VERSION}.jar import-certificate.sh && \
    chmod +x import-certificate.sh && \
    ./import-certificate.sh /etc/ssl/certs/java/cacerts && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ENV PATH $PATH:$TARGET

RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

ADD docker-entrypoint.sh $TARGET

CMD ["docker-entrypoint.sh"]
