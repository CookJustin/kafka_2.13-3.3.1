FROM ubuntu:18.04
RUN mkdir /kafka
COPY bin kafka/bin
COPY config /kafka/config
RUN dir kafka