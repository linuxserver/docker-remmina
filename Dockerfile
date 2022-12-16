# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG REMMINA_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    remmina \
    remmina-plugin-exec \
    remmina-plugin-kiosk \
    remmina-plugin-kwallet \
    remmina-plugin-rdp \
    remmina-plugin-secret \
    remmina-plugin-spice \
    remmina-plugin-vnc \
    remmina-plugin-www \    
    remmina-plugin-xdmcp \
    remmina-plugin-x2go && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /var/log/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
