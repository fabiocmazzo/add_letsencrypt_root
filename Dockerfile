# Example of add root certificate in Docker JDK

FROM openjdk:11-slim-sid

MAINTAINER Fabio Covolo Mazzo <fabiomazzo@gmail.com>

# Add the service itself
ADD target/yourapplication.jar /usr/share/dialogprocessor/yourapplication.jar
ADD install_lets_cert_root.sh /install_lets_cert_root.sh
RUN apt update && apt install wget -y
RUN /install_lets_cert_root.sh

ENTRYPOINT ["/usr/bin/java", "-XX:+ExitOnOutOfMemoryError", "-jar", "/usr/share/dialogprocessor/yourapplication.jar"]


