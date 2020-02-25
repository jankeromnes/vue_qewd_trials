# qewd-server

# Dockerised version of QEWD

# M/Gateway Developments Ltd
# 14 November 2019

#FROM node:boron
#FROM node:carbon
#FROM node:10-stretch
#FROM node:12-stretch
FROM gitpod/workspace-full:latest

#USER root

RUN sudo apt-get update && sudo apt-get install -y \
  build-essential \
  libssl-dev \
  dos2unix \
  wget \
  gzip \
  openssh-server \
  curl \
  python-minimal \
  libelf1 \
  locate \
  nano \
  subversion

RUN sudo echo 'deb http://ftp.debian.org/debian/ buster main' >> sudo /etc/apt/sources.list \
  && sudo echo ' this is sources list: ' \ 
  && sudo cat /etc/apt/sources.list \
  && sudo apt-get update 
#  && sudo apt-get -t buster install -y libc6 libncurses6


#RUN sudo echo 'deb http://ftp.debian.org/debian/ oldstable main' >> sudo /etc/apt/sources.list \
#  && sudo echo ' this is sources list: ' \ 
#  && sudo cat /etc/apt/sources.list \
#  && sudo apt-get update \
#  && sudo apt-get -t oldstable install -y libc6 libncurses6

#USER gitpod

# Create app directory
RUN sudo mkdir -p /opt/qewd
RUN sudo mkdir /opt/qewd/www
RUN sudo mkdir /opt/qewd/www/qewd-monitor

#WORKDIR /opt/qewd

COPY install_yottadb.sh /opt/qewd
COPY gde.txt /opt/qewd
RUN sudo chmod +x /opt/qewd/install_yottadb.sh

RUN cd /opt/qewd



# Install YottaDB & NodeM

RUN ["/opt/qewd/install_yottadb.sh"]

# Bundle app source
COPY . /opt/qewd

RUN sudo chmod +x /opt/qewd/ydb
RUN sudo chmod +x /opt/qewd/backup
RUN sudo chmod +x /opt/qewd/update_to_r128

RUN sudo echo 'YDB installed by now'

# move the qewd install stuff down here

# Install app dependencies
#COPY package.json /opt/qewd
RUN cd /opt/qewd

USER root
RUN cd /opt/qewd \
    && npm install qewd \
    && npm install \
    && npm install module-exists \
#    && npm install mg-dbx \
    && cp /opt/qewd/node_modules/qewd-monitor/www/bundle.js /opt/qewd/www/qewd-monitor \
    && cp /opt/qewd/node_modules/qewd-monitor/www/*.html /opt/qewd/www/qewd-monitor \
    && cp /opt/qewd/node_modules/qewd-monitor/www/*.css /opt/qewd/www/qewd-monitor \
    && cp /opt/qewd/node_modules/ewd-client/lib/proto/ewd-client.js /opt/qewd/www

# RUN npm install -g npm@latest
# RUN npm install 
# RUN npm install module-exists
# RUN npm install mg-dbx

RUN echo 'Done installing to this point - stopping here for now' 
#RUN cp /opt/qewd/node_modules/qewd-monitor/www/bundle.js /opt/qewd/www/qewd-monitor
#RUN cp /opt/qewd/node_modules/qewd-monitor/www/*.html /opt/qewd/www/qewd-monitor
#RUN cp /opt/qewd/node_modules/qewd-monitor/www/*.css /opt/qewd/www/qewd-monitor

#RUN cp /opt/qewd/node_modules/ewd-client/lib/proto/ewd-client.js /opt/qewd/www

#RUN cd /opt/qewd

#EXPOSE 8080

# ENTRYPOINT ["/bin/bash", "-l"]

#CMD [ "npm", "start" ]
USER root
