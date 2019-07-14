#!/bin/bash

# Download and install MediaWiki
# Pre-requisites : A mysql 5.6 service MEDIA_WIKI_DB_SERVER should be running with MEDIA_WIKI_DB_USER & MEDIA_WIKI_DB_PASS
#                  DB admin credentials has to be passed via MEDIA_WIKI_INSTALL_DB_USER  & MEDIA_WIKI_INSTALL_DB_PASS
# Author: ansilh@gmail.com


##---- Defaults ----##

DOC_ROOT=${DOC_ROOT:-"/var/www/mediawiki"}
MEDIA_WIKI_VERSION=${MEDIA_WIKI_VERSION:-"1.33"}
MEDIA_WIKI_SUB_VERSION=${MEDIA_WIKI_SUB_VERSION:-"0"}
MEDIA_WIKI_NAME=${MEDIA_WIKI_NAME:-"LinxLabs"}
MEDIA_WIKI_USER=${MEDIA_WIKI_USER:-"admin"}
MEDIA_WIKI_PASS=${MEDIA_WIKI_PASS:-"P@ssw0rd1234"}
MEDIA_WIKI_DB_USER=${MEDIA_WIKI_DB_USER:-"mediawiki"}
MEDIA_WIKI_DB_PASS=${MEDIA_WIKI_DB_PASS:-"mediawiki"}
MEDIA_WIKI_INSTALL_DB_USER=${MEDIA_WIKI_INSTALL_DB_USER:-"root"}
MEDIA_WIKI_INSTALL_DB_PASS=${MEDIA_WIKI_INSTALL_DB_PASS:-"password"}
MEDIA_WIKI_DB_TYPE=${MEDIA_WIKI_DB_TYPE:-"mysql"}
MEDIA_WIKI_DB_NAME=${MEDIA_WIKI_DB_NAME:-"linxlabs"}
MEDIA_WIKI_DB_SERVER=${MEDIA_WIKI_DB_SERVER:-"mysql"}
MEDIA_WIKI_DB_PORT=${MEDIA_WIKI_DB_PORT:-"3306"}
MEDIA_WIKI_LOGO=${MEDIA_WIKI_LOGO:-"https://raw.githubusercontent.com/ansilh/mediawiki-installer/master/linxlabs.png"}

##---- Download and extract  ----##
download_and_extract(){
        mkdir -p /var/www
        cd /tmp
        MEDIA_WIKI_URL="https://releases.wikimedia.org/mediawiki/${MEDIA_WIKI_VERSION}/mediawiki-${MEDIA_WIKI_VERSION}.${MEDIA_WIKI_SUB_VERSION}.tar.gz"
        if [ -f "${MEDIA_WIKI_URL##*/}" ]
        then 
                echo "INFO:File "${MEDIA_WIKI_URL##*/}" already exist"
        else
                wget -nv "${MEDIA_WIKI_URL}"
        fi
        tar -C /var/www -xzf "${MEDIA_WIKI_URL##*/}"
        mv /var/www/mediawiki* ${DOC_ROOT}
        rm -rf /tmp/mediawiki*
        #if [ -f ${DOC_ROOT}/resources/assets/wiki.png  ]
        #then        
        #        mv ${DOC_ROOT}/resources/assets/wiki.png ${DOC_ROOT}/resources/assets/wiki-stock.png
        #        wget -nv ${MEDIA_WIKI_LOGO}
        #        mv "${MEDIA_WIKI_LOGO##*/}"  ${DOC_ROOT}/resources/assets/wiki.png
        #fi
        wget -nv "${MEDIA_WIKI_LOGO}"
        STOCK_LOGO_MD5SUM=$(md5sum ${DOC_ROOT}/resources/assets/wiki.png |awk '{print $1}')
        DOWNLOAD_LOGO_MD5SUM=$(md5sum "${MEDIA_WIKI_LOGO##*/}"|awk '{print $1}')

        if [ "${STOCK_LOGO_MD5SUM}" == "${DOWNLOAD_LOGO_MD5SUM}" ]
        then
	        echo "INFO:Logo already copied"
                rm "${MEDIA_WIKI_LOGO##*/}"
        else
                mv "${MEDIA_WIKI_LOGO##*/}" ${DOC_ROOT}/resources/assets/wiki.png
        fi
        adduser -S -D -H nginx
        chown -R nginx ${DOC_ROOT}
}

##---- Wait for mysql to comeup ----#

wait_for_mysql(){
        until nc -vz "${MEDIA_WIKI_DB_SERVER}" "${MEDIA_WIKI_DB_PORT}" ; do echo Waiting for MySQL; sleep 3 ; done ;
}

##---- Installer  ----##
try_install(){
        download_and_extract
        wait_for_mysql
        cd ${DOC_ROOT}
        php maintenance/install.php \
        --wiki "${MEDIA_WIKI_NAME}" \
        --dbuser "${MEDIA_WIKI_DB_USER}" \
        --dbpass "${MEDIA_WIKI_DB_PASS}" \
        --dbname "${MEDIA_WIKI_DB_NAME}" \
        --dbprefix "${MEDIA_WIKI_NAME}_" \
        --dbserver "${MEDIA_WIKI_DB_SERVER}" --dbtype mysql \
        --installdbpass "${MEDIA_WIKI_INSTALL_DB_PASS}" \
        --installdbuser "${MEDIA_WIKI_INSTALL_DB_USER}" \
        --pass "${MEDIA_WIKI_PASS}" \
        --scriptpath "" \
        "${MEDIA_WIKI_NAME}" "${MEDIA_WIKI_USER}"
        if [ $? -ne 0 ]
        then
                return 1
        fi
}

##-- A hook for future user to upgarde existing MediaWiki --##
do_nothing(){
        echo "Moving on..."
}

##--- Main start ---#
# If LocalSettings.php is present , which means we are prceeding with an existing installation
# If LocalSettings.php is not present  , then run the installer

if [ -f ${DOC_ROOT}/LocalSettings.php ]
then
        do_nothing
else
        try_install
        if [ $? -ne 0 ]
        then
                echo "Something went wrong during installation.. :("
                exit 1
        else
              touch ${DOC_ROOT}/.ready

        fi
fi
nc -kl 8080