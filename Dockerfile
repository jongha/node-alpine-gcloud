FROM node:8-alpine
MAINTAINER Jong-Ha Ahn <jongha.ahn@mrlatte.net>

RUN mkdir -p /opt
WORKDIR /opt

RUN apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	git \
	openssh-client \
	python \
	tar \
	gzip

ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-218.0.0-linux-x86_64.tar.gz && tar zxvf google-cloud-sdk-218.0.0-linux-x86_64.tar.gz && rm google-cloud-sdk-218.0.0-linux-x86_64.tar.gz
RUN google-cloud-sdk/install.sh --path-update=true --bash-completion=true --rc-path=/root/.bashrc --additional-components app kubectl

RUN sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /opt/google-cloud-sdk/lib/googlecloudsdk/core/config.json

RUN mkdir ${HOME}/.ssh
ENV PATH /opt/google-cloud-sdk/bin:$PATH

WORKDIR /root
CMD bash
