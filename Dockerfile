FROM alpine:3.8

# Install required apckages.
RUN apk add --no-cache \
        php7 \
        php7-ctype \
        php7-dom \
        php7-iconv \
        php7-json \
        php7-simplexml \
        php7-tokenizer \
        php7-xmlwriter \
        php7-xml

# Install build only packages.
RUN apk add --no-cache -t .build-deps \
        curl \
        php7-openssl \
        php7-phar

RUN curl -Lo /usr/local/bin/composer https://getcomposer.org/composer.phar
RUN chmod +x /usr/local/bin/composer

# Install composer PHPCS requirements.
RUN composer global require 'squizlabs/php_codesniffer=3.3.0'
RUN composer global require 'escapestudios/symfony2-coding-standard=3.4.1'
RUN /root/.composer/vendor/bin/phpcs --config-set installed_paths /root/.composer/vendor/escapestudios/symfony2-coding-standard/Symfony

# Install composer PHPMD requirements.
RUN composer global require 'phpmd/phpmd=2.6.0'

# Install composer PHPCPD requirements.
RUN composer global require 'sebastian/phpcpd=4.1.0'

# Clean-up
RUN rm /usr/local/bin/composer \
 && apk del --purge .build-deps

# Create Default directory
RUN mkdir -p /code

# Register composer vendor bin directory.
ENV PATH=$PATH:/root/.composer/vendor/bin/

WORKDIR /code
VOLUME /code
