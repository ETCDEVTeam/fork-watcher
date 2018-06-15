FROM ubuntu

RUN  apt-get update \
  && apt-get install -y wget curl \
  && rm -rf /var/lib/apt/lists/*

COPY download.sh /
RUN chmod +x /download.sh

RUN /download.sh 4.2.2 c127446
RUN /download.sh 5.0.0 ac28808
RUN /download.sh 5.3.0 55fb00b
RUN ls -l /opt/geth

COPY start.sh /
RUN chmod +x /start.sh

EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/UDP

VOLUME /data

WORKDIR /opt/geth

CMD ["/start.sh"]