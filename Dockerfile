FROM alpine:3.9

LABEL maintainer="Ansil H <ansilh@gmail.com>"
LABEL version="0.0.1"
LABEL description="MediaWiki installer image should be started  as InitContainer before Nginx+php container"

ADD install.sh /

RUN chmod 755 /install.sh \
    && apk add --no-cache \
    coreutils \
    php7 \
    php7-curl \
    php7-xml \
    php7-fpm \
    php7-ctype \
    php7-gd \
    php7-json \
    php7-mysqli \
    php7-pdo_mysql \
    php7-dom \
    php7-openssl \
    php7-iconv \
    php7-opcache \
    php7-intl \
    php7-mcrypt \
    php7-common \
    php7-xmlreader \
    php7-phar \
    php7-mbstring \
    php7-session \
    php7-fileinfo \
    diffutils \
    git \
    bash \
    wget

ENTRYPOINT [ "/install.sh" ]
