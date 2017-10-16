#! /bin/bash

set -eu

ROOT_SCRIPT_DIR=$( dirname ${BASH_SOURCE[0]} )
CONF_DIR=$( dirname ${ROOT_SCRIPT_DIR} )/etc/import
LIBEXEC_DIR=$( dirname ${ROOT_SCRIPT_DIR} )/libexec
CONF_FILE=${CONF_DIR}/${1}.conf
POST_FILE=${CONF_DIR}/${1}.post

if [ -e ${CONF_FILE} ]; then
    . ${CONF_FILE}
else
    echo 'The configuration file does not exist, aborting'
    echo 'Currently available projects:'
    ls -1 ${CONF_DIR} | sed -e 's/^/\t- /g' -e 's/.conf//g'
    exit 1
fi

DATE="$(date +"%Y%m%d")"
AWS=$( which aws )

BACKUP_DIR="/tmp/parallel-loader"
mkdir -p ${BACKUP_DIR}

DUMP_DIR=${BACKUP_DIR}/${SOURCE_DB_DOMAIN}
rm -rf ${DUMP_DIR}
mkdir -p ${DUMP_DIR}

LOADER=${LIBEXEC_DIR}/myloader
MYSQL=$( which mysql )

S3_PATH="kg-backups/RDS/parallel-dumper"
S3_FULL_PATH="s3://${S3_PATH}/${BACKUP_TYPE}/${PROJECT}/${SOURCE_DB_DOMAIN}"

echo -n 'Getting database dump for '${TARGET_DB_DOMAIN}' environment from S3: '
${AWS} s3 sync --quiet ${S3_FULL_PATH} ${DUMP_DIR}/
echo 'OK'

echo -n 'Deleting database: '
${MYSQL} -u ${TARGET_DB_USER} -h ${TARGET_DB_HOST} -p${TARGET_DB_PASSWORD} -e "DROP DATABASE IF EXISTS ${TARGET_DB_NAME};"
echo 'OK'

echo -n 'Importing database: '
${LOADER} \
    --user=${TARGET_DB_USER} \
    --password=${TARGET_DB_PASSWORD} \
    --host=${TARGET_DB_HOST} \
    --threads=4 \
    --overwrite-tables \
    --database=${TARGET_DB_NAME} \
    --directory=${DUMP_DIR}
echo 'OK'

echo -n 'Cleaning work directory: '
rm -rf ${DUMP_DIR}
echo 'OK'
