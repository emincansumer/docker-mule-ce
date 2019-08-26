#!/bin/bash
set -e

printf "Starting Mule..."

# Start mule
${MULE_HOME}/bin/mule start -M-Dspring.profiles.active=${MULE_ENV} -M-DMULE_ENV=${MULE_ENV} --M-Dmule.env=${MULE_ENV} -M-Dmule.verbose.exceptions=true -M-Dmule.config.path=$MULE_HOME/conf/