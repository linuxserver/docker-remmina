# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
ARG REMMINA_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=Remmina

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/remmina-logo.png && \
  echo "**** install remmina ****" && \
  if [ -z "${REMMINA_RELEASE}" ]; then \
    REMMINA_RELEASE=$(curl -sX GET http://archive.ubuntu.com/ubuntu/dists/noble-updates/main/binary-amd64/Packages.gz | gunzip |grep -A 7 -m 1 'Package: remmina' | awk -F ': ' '/Version/{print $2;exit}'); \
  fi && \
  apt-get update && \
  apt-get install -y \
    remmina="${REMMINA_RELEASE}" \
    remmina-plugin-exec="${REMMINA_RELEASE}" \
    remmina-plugin-kiosk="${REMMINA_RELEASE}" \
    remmina-plugin-kwallet="${REMMINA_RELEASE}" \
    remmina-plugin-rdp="${REMMINA_RELEASE}" \
    remmina-plugin-secret="${REMMINA_RELEASE}" \
    remmina-plugin-spice="${REMMINA_RELEASE}" \
    remmina-plugin-vnc="${REMMINA_RELEASE}" \
    remmina-plugin-www="${REMMINA_RELEASE}" \
    remmina-plugin-x2go="${REMMINA_RELEASE}" && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
