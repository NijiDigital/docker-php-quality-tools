# Docker PHP Quality tools

This image contains some tools to checks the PHP code quality

## Tools in this image

* `phpcs`: PHP Code Sniffer  (https://github.com/squizlabs/PHP_CodeSniffer)
  To check if php code respect a predefined coding standard.
  Available Sniffs :
  * Generic
  * MySource
  * PEAR
  * PSR1
  * PSR12
  * PSR2
  * Squiz
  * Zend
  * Symfony (from https://github.com/djoos/Symfony-coding-standard)

* `phpstan`: PHP Static Analysis Tool (https://github.com/phpstan/phpstan)
  To check if php code respect a predefined coding standard.
  * Symfony Framework
  * Drupal

* `phpmd`: PHP Mess Detector (https://phpmd.org/)
  To check the php code complexity.
  
* `phpcpd`: PHP Copy Paste Detector (https://github.com/sebastianbergmann/phpcpd)
  To detect all Copy / Paste.

* `security-checker`: Composer security checker (https://github.com/sensiolabs/security-checker)
  To check if composer lock uses dependencies with known security vulnerabilities.


## Usage example

### phpcs

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpcs [options]`

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpcs --help`

Visit https://github.com/squizlabs/PHP_CodeSniffer for all `phpcs` usage.

### phpstan

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpstan [options]`

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpstan --help`

Visit https://github.com/phpstan/phpstan for all `phpstan` usage.

### phpmd

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpmd [options]`

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpmd --help`

Visit https://phpmd.org/ for all `phpmd` usage.

### phpcpd

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpcpd [options]`

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools phpcpd --help`

Visit https://github.com/sebastianbergmann/phpcpd for all `phpcpd` usage.

### security-checker

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools security-checker security:check <path-to-composer.lock>`

`$ docker run --rm -v $PWD:/code:ro niji/php-quality-tools security-checker help security:check`

Visit https://github.com/sensiolabs/security-checker for all `security-checker` usage.