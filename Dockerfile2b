FROM gitpod/workspace-full:latest

USER root
# Install custom tools, runtime, etc.

SHELL ["/bin/bash", "-c", "source install_yottadb1.sh"]


USER gitpod
# Apply user-specific settings
# ENV ...
# RUN npm install -g --unsafe-perm node-red 
#    && npm install -g json-server

# Give back control
USER root
