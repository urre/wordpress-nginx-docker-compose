FROM urre/wordpress-nginx-docker-compose-image:1.5.0

# Install wp-cli and dependencies (clean apt caches to keep the image small)
RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo less mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL -o /bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /bin/wp \
    && mkdir -p /var/www/.wp-cli/cache \
    && chown www-data:www-data /var/www/.wp-cli/cache

# Forward outgoing mail to Mailpit (the maintained successor to MailHog).
# mhsendmail is a tiny SMTP relay; it delivers PHP mail() to the mailpit service.
RUN curl -fsSL --output /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
    && chmod +x /usr/local/bin/mhsendmail \
    && echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailpit:1025 --from=no-reply@myapp.local"' > /usr/local/etc/php/conf.d/mailpit.ini

# Note: Use `docker compose up -d --force-recreate --build` when the Dockerfile has changed.
