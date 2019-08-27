FROM alpine:3.8

# Install required packages.
RUN apk add --no-cache \
        bash \
        ca-certificates \
        curl \
        php7 \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-iconv \
        php7-json \
        php7-mbstring \
        php7-openssl \
        php7-simplexml \
        php7-tokenizer \
        php7-xmlwriter \
        php7-xml \
        wget

# Install glibc
ENV GLIBC_VERSION 2.23-r3

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-$GLIBC_VERSION.apk" \
    &&  rm "glibc-$GLIBC_VERSION.apk" \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-bin-$GLIBC_VERSION.apk" \
    &&  rm "glibc-bin-$GLIBC_VERSION.apk" \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-i18n-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-i18n-$GLIBC_VERSION.apk" \
    &&  rm "glibc-i18n-$GLIBC_VERSION.apk"

RUN apk add libstdc++ \
        nodejs \
        shadow

# Install build only packages.
RUN apk add --no-cache -t .build-deps \
        php7-phar \
        git

RUN curl -Lo /usr/local/bin/composer https://getcomposer.org/composer.phar
RUN chmod +x /usr/local/bin/composer

RUN mkdir /usr/local/composer
ENV COMPOSER_HOME="/usr/local/composer" 

# Install PHPCS requirements.
RUN composer global require 'squizlabs/php_codesniffer ~3.3'

# Install Symfony PHPCS standard.
RUN composer global require 'escapestudios/symfony2-coding-standard ~3.4'
RUN $COMPOSER_HOME/vendor/bin/phpcs --config-set installed_paths $COMPOSER_HOME/vendor/escapestudios/symfony2-coding-standard/Symfony

# Install Drupal PHPCS standard.
RUN composer global require 'drupal/coder ~8.3'
RUN $COMPOSER_HOME/vendor/bin/phpcs --config-set installed_paths $COMPOSER_HOME/vendor/drupal/coder/coder_sniffer

# Install PHPStan requirements
RUN composer global require 'phpstan/phpstan ~0.11'

# Install PHPStan additonnal analysis
RUN composer global require 'phpstan/phpstan-symfony ~0.11'
RUN composer global require 'mglaman/phpstan-drupal ~0.11'

# Install PHPMD requirements.
RUN composer global require 'phpmd/phpmd ~2.6'

# Install PHPCPD requirements.
RUN composer global require 'sebastian/phpcpd ~4.1'

# Install Sensiolabs security checker requirements.
RUN composer global require 'sensiolabs/security-checker ~5.0'

# Clean-up
RUN rm /usr/local/bin/composer \
 && apk del --purge .build-deps

# Create Default directory
RUN mkdir -p /code

# Register composer vendor bin directory.
ENV PATH=$PATH:$COMPOSER_HOME/vendor/bin/

WORKDIR /code
VOLUME /code
