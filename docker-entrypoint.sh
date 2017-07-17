#!/bin/sh

#java -Dsbsrs.kafkaServer="$KAFKA_SERVER" -jar /opt/sbsrs/sbsrs.jar

MORE_MQTT_OPTIONS=''
if [ -n $MQTT_USER ]; then
    MORE_MQTT_OPTIONS="$MORE_MQTT_OPTIONS -Dmqtt.user=$MQTT_USER"
fi
if [ -n $MQTT_PASSWORD ]; then
    MORE_MQTT_OPTIONS="$MORE_MQTT_OPTIONS -Dmqtt.password=$MQTT_PASSWORD"
fi

echo "More MQTT: $MORE_MQTT_OPTIONS"

java -Dmqtt.brokerUrl=$CODEKUNST_SERVER -Dmqtt.topic=$CODEKUNST_TOPIC $MORE_MQTT_OPTIONS -Dkafka.server=$KAFKA_SERVER -jar CodekunstMQTTAdapter-assembly-$CODEKUNSTMQTT_VERSION.jar
