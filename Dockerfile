FROM python:2.7-slim
MAINTAINER Vladimir Osintsev <oc@co.ru>

ENV ELECTRUM_VERSION 2.7.4
ENV ELECTRUM_USER electrum-user
ENV ELECTRUM_HOME /home/$ELECTRUM_USER

RUN useradd -ms /usr/sbin/nologin $ELECTRUM_USER

RUN apt-get update -y && apt-get install -y socat

RUN pip install \
		https://download.electrum.org/${ELECTRUM_VERSION}/Electrum-${ELECTRUM_VERSION}.tar.gz

RUN mkdir -p ${ELECTRUM_HOME}/.electrum/ /data/ && \
		ln -sf ${ELECTRUM_HOME}/.electrum/ /data/ && \
		chown ${ELECTRUM_USER} ${ELECTRUM_HOME}/.electrum

USER $ELECTRUM_USER
WORKDIR $ELECTRUM_HOME

VOLUME /data

EXPOSE 7000

RUN electrum setconfig rpcport 7777

# TCP relay to localhost with socat
CMD electrum daemon start && socat TCP-LISTEN:7000,fork TCP:127.0.0.1:7777
