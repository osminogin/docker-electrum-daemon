FROM python:3.6-slim
LABEL maintainer="oc@co.ru"

RUN apt-get update -y && apt-get install --no-install-recommends -y \
	socat \
	telnet \
	netcat \
	curl

ENV ELECTRUM_VERSION 3.0.5
ENV ELECTRUM_USER electrum
ENV ELECTRUM_PASSWORD electrumz
ENV ELECTRUM_HOME /home/$ELECTRUM_USER

RUN useradd -m $ELECTRUM_USER

RUN pip3 install \
	https://download.electrum.org/${ELECTRUM_VERSION}/Electrum-${ELECTRUM_VERSION}.tar.gz

RUN mkdir -p ${ELECTRUM_HOME}/.electrum/ /data/ && \
	ln -sf ${ELECTRUM_HOME}/.electrum/ /data/ && \
	chown ${ELECTRUM_USER} ${ELECTRUM_HOME}/.electrum

USER $ELECTRUM_USER
WORKDIR $ELECTRUM_HOME

VOLUME /data

EXPOSE 7000

ADD run.sh /
ENTRYPOINT /run.sh
