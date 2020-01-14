
# Docker Compose and WordPress

[![Build Status](https://travis-ci.org/urre/wordpress-nginx-docker-compose.svg?branch=master)](https://travis-ci.org/urre/wordpress-nginx-docker-compose)

Use WordPress locally with Docker using [Docker compose](https://docs.docker.com/compose/)

+ `Dockerfile` for extending a base image with a custom [Docker image](https://github.com/urre/wordpress-nginx-docker-compose-image) with [automated build on Docker Hub](https://cloud.docker.com/repository/docker/urre/wordpress-nginx-docker-compose-image)
+ Custom domain for example `myapp.local`
+ Custom nginx config in `./nginx`
+ Custom PHP `php.ini` config in `./config`
+ Volumes for `nginx`, `wordpress` and `mariadb`
+ WordPress using [Bedrock](https://roots.io/bedrock/) - modern development tools, easier configuration, and an improved folder structure
+ Composer
+ PhpMyAdmin
+ CLI scripts
	- Create a self signed SSL certificate for using https
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

```yml
IP=127.0.0.1
APP_NAME=myapp
DOMAIN="myapp.local"
DB_HOST=mysql
DB_NAME=myapp
DB_ROOT_PASSWORD=password
DB_TABLE_PREFIX=wp_

```

#### For WordPress

Copy `.env-example` in the `src` folder to `.env` and edit your preferences.

Use the following database settings:

```yml
DB_HOST=mysql:3306
DB_NAME=myapp
DB_USER=root
DB_PASSWORD=password
```

### Create SSL cert

```shell
cd cli
./create-cert.sh
```

> Note: OpenSSL needs to be installed.

### Trust the cert in macOS Keychain

Chrome and Safari will trust the certs using this script.

> In Firefox: Select Advanced, Select the Encryption tab, Click View Certificates. Navigate to where you stored the certificate and click Open, Click Import.

```shell
cd cli
./trust-cert.sh
```

### Setup vhost in /etc/hosts

```shell
cd cli
./setup-hosts-file.sh
```
## Install WordPress and Composer dependencies

```shell
cd src
composer install
```

> You can also use composer like this: `docker-compose run composer update`

## Run

```shell
docker-compose up -d
```

🚀 Open up [https://myapp.local](https://myapp.local)

## PhpMyAdmin

PhpMyAdmin now comes installed as a service in docker-compose.

Open [http://127.0.0.1:8080/](http://127.0.0.1:8080/)

### Notes:

When making changes to the Dockerfile, use:

```bash
docker-compose up -d --force-recreate --build
```

### Tools

#### wp-cli

```
docker exec -it myapp-wordpress bash
wp search-replace https://olddomain.com https://newdomain.com --allow-root
```

> You can use this command first after you've installed WordPress using Composer as the example above.

### Changelog

#### 2020-01-11
- Added `.env` support for specifying your own app name, domain etc in Docker and cli scripts.
- Added phpMyAdmin. Visit [http://127.0.0.1:8080/](http://127.0.0.1:8080/)

#### 2019-08-02
- Added Linux support. Thanks to [@faysal-ishtiaq](https://github.com/faysal-ishtiaq).

***

### Useful Docker Commands

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
