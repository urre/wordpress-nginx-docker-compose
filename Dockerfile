FROM urre/wordpress-nginx-docker-compose-image

# Install wp-cli
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /bin/wp-cli.phar
RUN cd /bin && mv wp-cli.phar wp
RUN mkdir -p /var/www/.wp-cli/cache && chown www-data:www-data /var/www/.wp-cli/cache
RUN wp core install --url=http://compulsev2.local --title=radcli --admin_user=compulse_support --admin_password=2cSbmQWQOyB6QS1Sfh --admin_email=krwilliams@sbgtv.com --allow-root
# Note: Use docker-compose up -d --force-recreate --build when Dockerfile has changed.
