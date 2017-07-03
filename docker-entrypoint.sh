#!/bin/sh

#java -Dsbsrs.kafkaServer="$KAFKA_SERVER" -jar /opt/sbsrs/sbsrs.jar

java -Dmqtt.brokerUrl=$CODEKUNST_SERVER -Dmqtt.topic=$CODEKUNST_TOPIC -jar CodekunstMQTTAdapter-assembly-$CODEKUNSTMQTT_VERSION.jar
