FROM ndamiens/nginx-php:latest
RUN apt-get update && apt-get install -y cron \
	&& rm -rf /var/lib/apt/lists/*
ADD scripts scripts
ADD src src
ADD composer.json composer.lock propel.xml.dist schema.xml bootstrap.php /opt/app/
RUN composer install -o -q -n
CMD ["bash", "scripts/setup.sh"]
ADD tests tests
ADD phpunit.xml /opt/app
ADD drop_and_run.sh /opt/app
ADD www /opt/app/www
ADD templates templates
