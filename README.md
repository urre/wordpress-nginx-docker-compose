
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

Easily set your own local domain, db and wordpress settings and more. Start by creating an `.env` file, like the example below.

#### For Docker, the cli-scripts and WordPress (Bedrock)

Copy `.env-example` in the project root to `.env` and edit your preferences.

Tip: For the WordPress salts and keys go to [Roots.io's generator page](https://roots.io/salts.html) and copy the env format block.

Example:

```dotenv
### BASE CONFIG ###
IP=127.0.0.1
APP_NAME=myapp
DOMAIN=myapp.local
DB_HOST=mysql
DB_NAME=myapp
DB_ROOT_PASSWORD=password
DB_TABLE_PREFIX=wp_

### BEDROCK CONFIG ###
DB_USER=root

WP_ENV=development
WP_HOME=https://${DOMAIN}
WP_SITEURL=${WP_HOME}/wp

# Generate your keys here: https://roots.io/salts.html and copy/paste the env format block
# just replace the whole block below :)
AUTH_KEY='generateme'
SECURE_AUTH_KEY='generateme'
LOGGED_IN_KEY='generateme'
NONCE_KEY='generateme'
AUTH_SALT='generateme'
SECURE_AUTH_SALT='generateme'
LOGGED_IN_SALT='generateme'
NONCE_SALT='generateme'
```

** ~~DON'T~~ NEVER EVER USE THE KEYS AND SALTS FROM THIS EXAMPLE! **

#### Generate Bedrock environment

When you are done editing your `.env` file, change back into the `cli` directory and run the `setup-bedrock-env`-script.
It will create an .env file in the `src` directory, containing all settings for a working Bedrock installation:
```shell
cd cli
./setup-bedrock-env.sh
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

Follow the instructions.

### Setup nginx config

From within the cli directory run the following script:
```shell
cd cli
./setup-nginx-config.sh
```
It generates the `nginx/wordpress_ssl.conf` file with your own local domain of choice.

If the file already exists, a backup will be created each time.
If you don't want backups of your nginx conf, run the script with `-nb` (means: "no backup"):
```shell
./setup-nginx-config.sh -nb
```


## Install WordPress and Composer dependencies

```shell
docker-compose run composer intall
```
> If you have Composer installed on your Mac you can also use `cd src && composer install`

## Run

```shell
docker-compose up -d
```

docker-compose will start all the services for you:


```shell
Starting myapp-mysql    ... done
Starting myapp-composer ... done
Starting myapp-phpmyadmin ... done
Starting myapp-wordpress  ... done
Starting myapp-nginx      ... done
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
