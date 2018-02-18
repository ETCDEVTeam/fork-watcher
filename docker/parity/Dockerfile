FROM ubuntu

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

COPY download.sh /
RUN chmod +x /download.sh

RUN /download.sh 1.6.8
RUN /download.sh 1.6.9
RUN /download.sh 1.7.9
RUN ls -l /opt/parity

COPY start.sh /
RUN chmod +x /start.sh

EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/UDP

VOLUME /data

WORKDIR /opt/parity

CMD ["/start.sh"]