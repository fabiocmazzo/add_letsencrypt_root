#!/bin/bash
set -e

JAVA_HOME=/usr/lib/jvm/zulu-8-amd64

KEYSTORE=/docker-java-home/lib/security/cacerts

wget https://letsencrypt.org/certs/isrgrootx1.der
wget https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.der
wget https://letsencrypt.org/certs/lets-encrypt-x4-cross-signed.der

# to be idempotent
keytool -delete -alias isrgrootx1 -keystore $KEYSTORE -storepass changeit 2> /dev/null || true
keytool -delete -alias letsencryptauthorityx3 -keystore $KEYSTORE -storepass changeit 2> /dev/null || true
keytool -delete -alias letsencryptauthorityx4 -keystore $KEYSTORE -storepass changeit 2> /dev/null || true

keytool -trustcacerts -keystore $KEYSTORE -storepass changeit -noprompt -importcert -alias isrgrootx1 -file isrgrootx1.der
keytool -trustcacerts -keystore $KEYSTORE -storepass changeit -noprompt -importcert -alias letsencryptauthorityx3 -file lets-encrypt-x3-cross-signed.der
keytool -trustcacerts -keystore $KEYSTORE -storepass changeit -noprompt -importcert -alias letsencryptauthorityx4 -file lets-encrypt-x4-cross-signed.der

rm -f isrgrootx1.der lets-encrypt-x3-cross-signed.der lets-encrypt-x4-cross-signed.der
