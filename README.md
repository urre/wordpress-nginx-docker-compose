
# Docker Compose and WordPress

[![Build Status](https://travis-ci.org/urre/wordpress-nginx-docker-compose.svg?branch=master)](https://travis-ci.org/urre/wordpress-nginx-docker-compose)

[![Donate](https://img.shields.io/badge/Donation-green?logo=paypal&label=Paypal)](https://www.paypal.me/urbansanden)

Use WordPress locally with Docker using [Docker compose](https://docs.docker.com/compose/)

This setup comes shipped with:

+ A `Dockerfile` for extending a base image and using a custom [Docker image](https://github.com/urre/wordpress-nginx-docker-compose-image) with an [automated build on Docker Hub](https://cloud.docker.com/repository/docker/urre/wordpress-nginx-docker-compose-image)
+ Custom domain for example `myapp.local`
+ Custom nginx config in `./nginx`
+ Custom PHP `php.ini` config in `./config`
+ Volumes for `nginx`, `wordpress` and `mariadb`
+ [Bedrock](https://roots.io/bedrock/) - modern development tools, easier configuration, and an improved secured folder structure for WordPress
+ Composer
+ [WP-CLI](https://wp-cli.org/) - WP-CLI is the command-line interface for WordPress.
+ [MailHog](https://github.com/mailhog/MailHog) - An email testing tool for developers. Configure your outgoing SMTP server and view your outgoing email in a web UI.
+ [PhpMyAdmin](https://www.phpmyadmin.net/) - free and open source administration tool for MySQL and MariaDB
	- PhpMyAdmin config in `./config`
+ CLI scripts
	- Create a self signed SSL certificate for using HTTPS
	- Trust certs in macOS System Keychain
	- Setup the local domain in your in `/etc/hosts`

## Setup

### Requirements

+ [Docker](https://www.docker.com/get-started)
+ Openssl for creatng the SSL cert. Install using Homebrew `brew install openssl`

### Setup environment variables

Easily set your own local domain, db settings and more. Start by creating `.env` files, like the examples below.

#### For Docker and the cli scripts

Copy `.env-example` in the project root to `.env` and edit your preferences.

Example:

```dotenv
IP=127.0.0.1
APP_NAME=myapp
DOMAIN="myapp.local"
DB_HOST=mysql
DB_NAME=myapp
DB_ROOT_PASSWORD=password
DB_TABLE_PREFIX=wp_

```

#### For WordPress

Edit `./src/.env-example` to your needs. During the `composer create-project` command described below, an `./src/.env` will be created.

### Create SSL cert

#### macOS and Linux

```shell
cd cli
./create-cert.sh
```

> Note: OpenSSL needs to be installed.

### Windows

Use the bat file in in `./cli/windows scripts/create-cert.bat`

### Trust the cert

#### Add to macOS Keychain

Chrome and Safari will trust the certs using this script.

> In Firefox: Select Advanced, Select the Encryption tab, Click View Certificates. Navigate to where you stored the certificate and click Open, Click Import.

```shell
cd cli
./trust-cert.sh
```

#### Windows

Follow the instructions in  `./cli/windows scripts/trust-cert.txt`

### Add the local domain in /etc/hosts

To be able to use for example `https://myapp.local` in our browser, we need to modify the `/etc/hosts` file on our local machine to point the custom domain name. The `/etc/hosts` file contains a mapping of IP addresses to URLs.

#### macOS and Linux

```shell
cd cli
./setup-hosts-file.sh
```

> The helper script can both add or remove a entry from /etc/hosts. First enter the domain name, then press "a" for add, or "r" to remove. Follow the instructions on the screen.

#### Windows

Follow the instructions in  `./cli/windows scripts/setup-hosts-file.txt`

## Install

```shell
docker-compose run composer create-project
```

## Run

```shell
docker-compose up -d
```

> -d is for detached mode, this will run containers in the background.

Docker Compose will now start all the services for you:

```shell
Starting myapp-mysql    ... done
Starting myapp-composer ... done
Starting myapp-phpmyadmin ... done
Starting myapp-wordpress  ... done
Starting myapp-nginx      ... done
Starting myapp-mailhog    ... done
```

🚀 Open [https://myapp.local](https://myapp.local) in your browser

## PhpMyAdmin

PhpMyAdmin comes installed as a service in docker-compose.

🚀 Open [http://127.0.0.1:8080/](http://127.0.0.1:8080/) in your browser

## MailHog

MailHog comes installed as a service in docker-compose.

🚀 Open [http://127.0.0.1:8025/](http://127.0.0.1:8025/) in your browser


## Tools

### Update WordPress Core and Composer packages (plugins/themes)

```shell
docker-compose run composer update
```

#### Use wp-cli

```shell
docker exec -it myapp-wordpress bash
```

Login to the container

```shell
wp search-replace https://olddomain.com https://newdomain.com --allow-root
```

Run a wp-cli command

> You can use this command first after you've installed WordPress using Composer as the example above.

### Update plugins and themes from wp-admin?

You can, but I recommend to use Composer for this only. But to enable this edit `./src/config/environments/development.php` (for example to use it in Dev)

```shell
Config::define('DISALLOW_FILE_EDIT', false);
Config::define('DISALLOW_FILE_MODS', false);
```

### Useful Docker Commands

When making changes to the Dockerfile, use:

```bash
docker-compose up -d --force-recreate --build
```

Login to the docker container

```shell
docker exec -it myapp-wordpress bash
```

Stop

```shell
docker-compose stop
```

Down (stop and remove)

```shell
docker-compose down
```

Cleanup

```shell
docker-compose rm -v
```

Recreate

```shell
docker-compose up -d --force-recreate
```

Rebuild docker container when Dockerfile has changed

```shell
docker-compose up -d --force-recreate --build
```


### Changelog

#### 2020-10-04
- Added mysql-client (Solves [#54](https://github.com/urre/wordpress-nginx-docker-compose/issues/54))
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

***
