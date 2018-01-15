FROM ubuntu:14.04


RUN apt-get update
RUN dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get -y install wget vim unzip vim unzip
RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

WORKDIR /usr/local/src
RUN wget https://github.com/dogecoin/dogecoin/releases/download/v1.10.0/dogecoin-1.10.0-linux64.tar.gz
RUN tar -xzvf dogecoin-1.10.0-linux64.tar.gz
RUN chmod +x dogecoin-1.10.0/bin/dogecoind dogecoin-1.10.0/bin/dogecoin-cli
RUN ln -s /usr/local/src/dogecoin-1.10.0/bin/dogecoind /usr/local/bin/dogecoind
RUN ln -s /usr/local/src/dogecoin-1.10.0/bin/dogecoin-cli /usr/local/bin/dogecoin-cli


	

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.dogecoin \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.dogecoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22555 22556
CMD ["dogecoind"]
