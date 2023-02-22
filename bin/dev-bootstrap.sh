#!/usr/bin/env sh
set -e

# compile PHP
# ./configure  --enable-cli --enable-fpm --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite=/usr/local --with-sqlite3=/usr/local --enable-pcntl --enable-sockets --enable-mbstring --with-pcre-regex --with-curl=/usr/include --enable-gd-native-ttf --with-bz2 --with-zlib --with-zip --with-openssl=/usr/local/ --prefix=/usr/local --enable-gd --with-sodium --with-jpeg --with-webp --with-iconv=$(brew --prefix libiconv) --with-regex=pcre --with-xmlrpc --with-xsl PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig:/usr/local/opt/curl/lib/pkgconfig:/usr/local/opt/oniguruma/lib/pkgconfig:/usr/local/opt/libxslt/lib/pkgconfig

if [ "$1" == "static" ]; then
	sudo nginx -c "$HOME/code/conf/nginx/conf/nginx.conf"
fi

## redis is now clustered in it's own repo

if [ "$1" == "up" ]; then
	sudo nginx -c "$HOME/code/conf/nginx/conf/nginx.conf"
	sudo php-fpm --fpm-config "$HOME/code/conf/php/7.4 macOS build/php-fpm.conf" -c "$HOME/code/conf/php/7.4 macOS build/php.ini"
	# redis-server "$HOME/code/conf/redis/7.0.4/redis.conf"
fi

if [ "$1" == "down" ]; then
	sudo nginx -s stop
	sudo killall -m php
	# redis-cli SHUTDOWN
fi

