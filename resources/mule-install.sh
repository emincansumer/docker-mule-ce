#!/bin/bash
set -e
MULE_HOME=/opt/mule
    
MULE_PACKAGE_NAME="mule-standalone-3.9.0"
MULE_PACKAGE_URL=https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.9.0/${MULE_PACKAGE_NAME}.zip

# download mule runtime if it is not already in the docker container
if [ ! -f /opt/${MULE_PACKAGE_NAME}.zip ]; then
    echo "Downloading Mule Runtime CE"
    cd /opt && wget ${MULE_PACKAGE_URL}
fi

# unzip package and move all files to mule home
mkdir -p ${MULE_HOME}
cd /opt && unzip ${MULE_RUNTIME_CE}.zip && mv /opt/${MULE_RUNTIME_CE}/* ${MULE_HOME}/ && rm -rf ${MULE_RUNTIME_CE} && rm -rf ${MULE_RUNTIME_CE}.zip


# move start script to correct location
chmod 755 /opt/mule-start.sh && mv /opt/mule-start.sh /opt/mule/bin/

# move overriden wrapper config
CONFIG_OVERRIDE_FILE="/opt/wrapper-override.conf"
if ls ${CONFIG_OVERRIDE_FILE} 1> /dev/null 2>&1; then
    cp ${MULE_HOME}/conf/wrapper.conf ${MULE_HOME}/conf/wrapper.conf.bak
    cp -rf ${CONFIG_OVERRIDE_FILE} ${MULE_HOME}/conf/wrapper.conf
    rm -rf ${CONFIG_OVERRIDE_FILE}
fi

# remove installation script
if [ ! -f /opt/mule-install.sh ]; then
    rm -rf /opt/mule-install.sh
fi