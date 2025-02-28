FROM ubuntu:24.04

RUN apt update \
    && apt install -y wget build-essential flex bison bc libssl-dev procps libelf-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
RUN wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.8.tar.xz -O /tmp/linux-6.8.tar.xz \
    && tar -xf /tmp/linux-6.8.tar.xz -C /usr/src
