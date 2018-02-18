FROM ubuntu

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

COPY download.sh /
RUN chmod +x /download.sh

RUN /download.sh 3.5.86
RUN /download.sh 4.0.0
RUN /download.sh 4.1.2
RUN ls -l /opt/geth

COPY start.sh /
RUN chmod +x /start.sh

EXPOSE 8545
EXPOSE 30303

VOLUME /data

WORKDIR /opt/geth

CMD ["/start.sh"]