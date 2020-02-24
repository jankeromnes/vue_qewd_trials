FROM gitpod/workspace-full:latest

USER root
# Install custom tools, runtime, etc.
#RUN npm install -g --unsafe-perm node-red
#RUN npm install -g json-server
## RUN wget https://raw.githubusercontent.com/robtweed/qewd/master/installers/install_yottadb.sh
#RUN cd ~
#RUN wget https://raw.githubusercontent.com/robtweed/qewd/master/installers/install_yottadb.sh
#RUN source install_yottadb.sh
RUN echo 'Preparing environment' \ 
 && sudo apt-get update \ 
 && sudo apt-get install -y build-essential libssl-dev dos2unix \ 
 && sudo apt-get install -y wget gzip openssh-server curl python-minimal libelf1

# YottaDB

ENV ydbversion=r1.24

RUN echo "Installing YottaDB $ydbversion"

RUN mkdir /tmp/tmp # Create a temporary directory for the installer
RUN cd /tmp/tmp    # and change to it. Next command is to download the YottaDB installer
RUN wget https://gitlab.com/YottaDB/DB/YDB/raw/master/sr_unix/ydbinstall.sh
RUN chmod +x ydbinstall.sh # Make the file executable
  
ENV gtmroot=/usr/lib/yottadb
ENV gtmcurrent=$gtmroot/current  
  
RUN  if [ -e "$gtmcurrent"] ; then mv -v $gtmcurrent $gtmroot/previous_`date -u +%Y-%m-%d:%H:%M:%S` fi
RUN sudo mkdir -p $gtmcurrent # make sure directory exists for links to current YottaDB
RUN sudo ./ydbinstall.sh --utf8 default --verbose --linkenv $gtmcurrent --linkexec $gtmcurrent $ydbversion
RUN echo "Configuring YottaDB $ydbversion"
  
ENV gtmprof=$gtmcurrent/gtmprofile
ENV gtmprofcmd="source $gtmprof"
ENV $gtmprofcmd
ENV tmpfile=`mktemp`  
  
#RUN install_yottadb1.sh

USER gitpod
# Apply user-specific settings
# ENV ...
#RUN npm install -g --unsafe-perm node-red 
#    && npm install -g json-server

# Give back control
USER root
