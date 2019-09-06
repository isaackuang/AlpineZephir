FROM isaackuang/alpine-base:3.8.1


RUN apk add --update curl ca-certificates && \
    apk --no-cache --progress add \
    re2c g++ gcc make zlib-dev wget autoconf automake curl git \
    php7-dev php7-phar php7-openssl php7-json php7-iconv \
    php7-dom php7-xml php7-fileinfo php7-mbstring && \
    rm /var/cache/apk/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN cd /tmp && \
    git clone git://github.com/phalcon/php-zephir-parser.git && \
    cd php-zephir-parser && \
    phpize && \
    ./configure && \
    make && make install && \
    echo "extension=zephir_parser.so" >> /etc/php7/php.ini && \
    cd /tmp && \
    wget https://github.com/phalcon/zephir/releases/download/0.12.2/zephir.phar && \
    mv zephir.phar /usr/bin/zephir && chmod +x /usr/bin/zephir


WORKDIR /var/www/html

ENTRYPOINT ["sh"]
