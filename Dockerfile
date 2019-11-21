FROM nikeda/alpine-anaconda:latest
MAINTAINER Naoya Ikeda <n_ikeda@hotmail.com>
ENV USER worker
ENV HOME /home/${USER}
ENV SHELL /bin/bash

RUN apk add sudo

RUN adduser -S ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "${USER}:worker_pass" | chpasswd
USER ${USER}
WORKDIR ${HOME}

