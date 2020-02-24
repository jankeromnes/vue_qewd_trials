FROM gitpod/workspace-full:latest

USER root
# Install custom tools, runtime, etc.
#RUN npm install -g --unsafe-perm node-red
#RUN npm install -g json-server
## RUN wget https://raw.githubusercontent.com/robtweed/qewd/master/installers/install_yottadb.sh
RUN install_yottadb1.sh

USER gitpod
# Apply user-specific settings
# ENV ...
#RUN npm install -g --unsafe-perm node-red 
#    && npm install -g json-server

# Give back control
USER root
