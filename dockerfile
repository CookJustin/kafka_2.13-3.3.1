FROM openjdk:11-jre-slim
RUN mkdir /kafka
COPY . kafka
RUN dir kafka