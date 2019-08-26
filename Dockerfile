FROM ubuntu:xenial

# Update ubuntu
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get clean

# Install necessary tools
RUN apt-get install -y software-properties-common \
 && add-apt-repository ppa:openjdk-r/ppa \
 && apt-get update \
 && apt-get install -y zip \
 && apt-get install -y curl \
 && apt-get install -y htop \
 && apt-get install -y vim \
 && apt-get install -y wget \
 && apt-get install -y sudo \
 && apt-get install -y unzip \
 && apt-get install -y openjdk-8-jdk \
 && apt-get clean

COPY resources/ /opt/

# Environment variables

# mule home
ENV MULE_HOME /opt/mule

# default environment - can be passed as argument
ENV MULE_ENV sandbox

# download and install mule ce runtime
RUN chmod 755 /opt/mule-install.sh
RUN /opt/mule-install.sh


WORKDIR /opt/mule

# Default ports - may vary per configuration

# http.port
EXPOSE 8081

# https.port
EXPOSE 8082

CMD [ "/opt/mule/bin/mule-start.sh" ]