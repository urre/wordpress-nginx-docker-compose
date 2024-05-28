
# Docker Compose and WordPress

[![CI](https://github.com/urre/wordpress-nginx-docker-compose/actions/workflows/ci.yml/badge.svg)](https://github.com/urre/wordpress-nginx-docker-compose/actions/workflows/ci.yml)

[![Donate](https://img.shields.io/badge/Donation-green?logo=paypal&label=Paypal)](https://www.paypal.me/urbansanden)

Use WordPress locally with Docker using [Docker compose](https://docs.docker.com/compose/)

## Contents

+ A `Dockerfile` for extending a base image and using a custom [Docker image](https://github.com/urre/wordpress-nginx-docker-compose-image) with an [automated build on Docker Hub](https://cloud.docker.com/repository/docker/urre/wordpress-nginx-docker-compose-image)
+ PHP 8.1
+ Custom domain and HTTPS support. So you can use for example [https://myapp.local](https://myapp.local)
+ Custom nginx config in `./nginx`
+ Custom PHP `php.ini` config in `./config`
+ Volumes for `nginx`, `wordpress` and `mariadb`
+ [Composer](https://getcomposer.org/) - dependency manager for PHP
+ [Bedrock](https://roots.io/bedrock/) - modern development tools, easier configuration, and an improved secured folder structure for WordPress
+ [WP-CLI](https://wp-cli.org/) - WP-CLI is the command-line interface for WordPress.
+ [MailHog](https://github.com/mailhog/MailHog) - An email testing tool for developers. Configure your outgoing SMTP server and view your outgoing email in a web UI.
+ [PhpMyAdmin](https://www.phpmyadmin.net/) - free and open source administration tool for MySQL and MariaDB
	- PhpMyAdmin config in `./config`
+ [CLI script](https://github.com/urre/wordpress-nginx-docker-compose#:~:text=6%20minutes%20ago-,cli,-Use%20%2Dinstall%20for) to create a SSL certificate using [mkcert](https://github.com/FiloSottile/mkcert)

## Instructions and help

See the new [Wiki](https://github.com/urre/wordpress-nginx-docker-compose/wiki)

## Changelog

#### 2024-05-28
- Update Composer to use PHP 8.1
- Added a [GitHub Wiki for instructions](https://github.com/urre/wordpress-nginx-docker-compose/wiki)
#### 2022-05-28
- Use PHP 8.1 [Dockerfile](https://github.com/urre/wordpress-nginx-docker-compose-image/blob/master/Dockerfile) is updated.
#### 2022-05-28
- Use php:8.0-fpm-alpine as the base image on the image in Dockerfile [](https://hub.docker.com/repository/registry-1.docker.io/urre/wordpress-nginx-docker-compose-image/general)
#### 2022-05-28
- Updated the Docker image to use PHP 8
#### 2021-08-04
- Updated to WordPress 5.8.0
#### 2021-03-16
- Changed root `.env-example` to `.env.example` to match the git ignore patterns. Thanks [@scottnunemacher](https://github.com/scottnunemacher)
#### 2021-03-05
- Clarify steps in the readme
#### 2021-03-02
- Fixed a misstake so instead of `./src/.env-example`, it should be `./src/.env.example`.
- Redirect HTTP to HTTPS. Thanks [@humblecoder](https://github.com/humblecoder)
#### 2021-01-02
- Use `NGINX_ENVSUBST_TEMPLATE_SUFFIX`. Use a template and better substution of ENV variables in nginx config.
#### 2020-10-04
- Added mariadb-client (Solves [#54](https://github.com/urre/wordpress-nginx-docker-compose/issues/54))
#### 2020-09-15
- Updated Bedrock. Update WordPress to 5.5.1 and other composer updates.
#### 2020-07-12
- Added Mailhog. Thanks [@mortensassi](https://github.com/mortensassi)
#### 2020-05-03
- Added nginx gzip compression
#### 2020-04-19
- Added Windows support for creating SSH cert, trusting it and setting up the host file entry. Thanks to [@styssi](https://github.com/styssi)
#### 2020-04-12
- Remove port number from `DB_HOST`. Generated database connection error in macOS Catalina. Thanks to [@nirvanadev](https://github.com/nirvanadev)
- Add missing ENV variable from mariadb Thanks to [@vonwa](https://github.com/vonwa)
#### 2020-03-26
- Added phpMyAdmin config.Thanks to [@titoffanton](https://github.com/titoffanton)
#### 2020-02-06
- Readme improvements. Explain `/etc/hosts` better
#### 2020-01-30
- Use `Entrypoint` command in Docker Compose to replace the domain name in the nginx config. Removing the need to manually edit the domain name in the nginx conf. Now using the `.env` value `DOMAIN`
- Added APP_NAME in `.env-example` Thanks to [@Dave3o3](https://github.com/Dave3o3)
#### 2020-01-11
- Added `.env` support for specifying your own app name, domain etc in Docker and cli scripts.
- Added phpMyAdmin. Visit [http://127.0.0.1:8080/](http://127.0.0.1:8080/)

#### 2019-08-02
- Added Linux support. Thanks to [@faysal-ishtiaq](https://github.com/faysal-ishtiaq).

</details>
