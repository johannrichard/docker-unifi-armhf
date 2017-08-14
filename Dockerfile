FROM praseodym/arm32v7-debian-oracle-java:jessie

# Download Testing
ARG UNIFI_VERSION=5.6.14-f7a900184a

RUN export DEBIAN_FRONTEND='noninteractive' && apt-get update

# Break it up to speed up build
RUN apt-get install -y --no-install-recommends mongodb-server jsvc && \
    wget -nv https://www.ubnt.com/downloads/unifi/$UNIFI_VERSION/unifi_sysvinit_all.deb && \
    dpkg --install unifi_sysvinit_all.deb && \
    rm unifi_sysvinit_all.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 6789/tcp 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp
VOLUME /usr/lib/unifi/data /usr/lib/unifi/run

ENTRYPOINT ["/usr/bin/java", "-Xmx512M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
