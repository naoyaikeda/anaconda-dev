FROM nikeda/alpine-anaconda:latest
MAINTAINER Naoya Ikeda <n_ikeda@hotmail.com>
ENV USER worker
ENV HOME /home/${USER}
ENV SHELL /bin/bash

RUN apk add sudo && \
    apk add shadow && \
    useradd -m ${USER} && \
    gpasswd -a ${USER} wheel && \
    sed -e 's;^# \(%wheel.*NOPASSWD.*\);\1;g' -i /etc/sudoers && \
    echo "${USER}:worker_pass" | chpasswd
USER ${USER}
WORKDIR ${HOME}

