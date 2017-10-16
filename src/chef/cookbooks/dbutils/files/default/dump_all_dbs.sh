#! /bin/bash

set -u

ROOT_SCRIPT_DIR=$( dirname ${BASH_SOURCE[0]} )
CONF_DIR=$( dirname ${ROOT_SCRIPT_DIR} )/etc

for site in $( ls -1 ${CONF_DIR}/dump/*conf ); do
    parameter=$( basename $site .conf )
    echo -e "\n\nStarting dump for ${parameter}\n"
    ${ROOT_SCRIPT_DIR}/dump_db.sh $parameter
done
