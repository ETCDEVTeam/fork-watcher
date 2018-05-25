FROM ubuntu

RUN  apt-get update \
  && apt-get install -y wget libssl1.0.0 \
  && rm -rf /var/lib/apt/lists/*

COPY download.sh /
RUN chmod +x /download.sh

RUN /download.sh 1.9.2
RUN /download.sh 1.9.3
RUN /download.sh 1.9.7
RUN /download.sh 1.10.4
RUN ls -l /opt/parity

COPY start.sh /
RUN chmod +x /start.sh

EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/UDP

VOLUME /data

WORKDIR /opt/parity

CMD ["/start.sh"]