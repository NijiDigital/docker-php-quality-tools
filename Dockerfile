FROM alpine:3.8

# Install required apckages.
RUN apk add --no-cache \
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
        php7-xml

# Install build only packages.
RUN apk add --no-cache -t .build-deps \
        php7-phar \
        git

RUN curl -Lo /usr/local/bin/composer https://getcomposer.org/composer.phar
RUN chmod +x /usr/local/bin/composer

# Install PHPCS requirements.
RUN composer global require 'squizlabs/php_codesniffer ~3.3'

# Install Symfony PHPCS standard.
RUN composer global require 'escapestudios/symfony2-coding-standard ~3.4'
RUN /root/.composer/vendor/bin/phpcs --config-set installed_paths /root/.composer/vendor/escapestudios/symfony2-coding-standard/Symfony

# Install Drupal PHPCS standard.
RUN composer global require 'drupal/coder ~8.3'
RUN /root/.composer/vendor/bin/phpcs --config-set installed_paths /root/.composer/vendor/drupal/coder/coder_sniffer

# Install PHPStan requirements
RUN composer global require 'phpstan/phpstan ~0.11'

# Install PHPStan additonnal analysis
RUN composer global require 'phpstan/phpstan-symfony ~0.11'
RUN composer global require 'phpstan/extension-installer ~1.0'
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
ENV PATH=$PATH:/root/.composer/vendor/bin/

WORKDIR /code
VOLUME /code
