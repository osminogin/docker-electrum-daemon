FROM python:2.7-slim
MAINTAINER Vladimir Osintsev <oc@co.ru>

ENV ELECTRUM_VERSION 2.7.12
ENV ELECTRUM_USER electrum-user
ENV ELECTRUM_HOME /home/$ELECTRUM_USER

RUN useradd -m $ELECTRUM_USER

RUN apt-get update -y && apt-get install -y python-qt4 socat telnet netcat curl

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
CMD electrum daemon start && socat -v TCP-LISTEN:7000,fork TCP:127.0.0.1:7777
