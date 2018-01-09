#!/usr/bin/env bash

set -e
trap '>&2 echo Error: Command \`$BASH_COMMAND\` on line $LINENO failed with exit code $?' ERR

PHPVER=$(phpenv version-name)
INSTALL_COMMAND="composer install --no-interaction --prefer-dist"
UPDATE_COMMAND="composer update --no-interaction --prefer-source"

if [ "$deps" -eq "no" ]; then

    # if PHP version is 5, use travis_wait for up to 20 minutes waiting time.
    if [ "$PHPVER" -eq "5" ]; then
        travis_wait ${INSTALL_COMMAND}
    fi

    if [ "$PHPVER" -eq "7" ]; then
        ${INSTALL_COMMAND}
    fi
fi

if [ "$deps" -eq "high" ]; then
    ${UPDATE_COMMAND}
fi