FROM openjdk:11-jre-slim

RUN mkdir /kafka
COPY . kafka
RUN dir kafka
RUN apt-get update && apt-get install -y netcat
# We shouldnt need this because we are going to make a kubernetes service anyways.
EXPOSE 2181 9092

CMD echo "Starting Zookeeper..." \
    && /bin/bash -c "/kafka/bin/zookeeper-server-start.sh /kafka/config/zookeeper.properties &" \
    && ZOOKEEPER_PID=$! \
    && /bin/bash -c "wait $ZOOKEEPER_PID && ZOOKEEPER_EXIT_CODE=$? && echo \"Zookeeper exit code: $ZOOKEEPER_EXIT_CODE\" && if [ $ZOOKEEPER_EXIT_CODE -ne 0 ]; then echo \"Zookeeper exited with non-zero exit code. Exiting.\"; exit $ZOOKEEPER_EXIT_CODE; else echo \"Starting Kafka Server...\" && /kafka/bin/kafka-server-start.sh /kafka/config/server.properties; fi"
