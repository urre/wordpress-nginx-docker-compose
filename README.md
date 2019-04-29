
# Docker Compose and WordPress

[![Build Status](https://travis-ci.org/urre/wordpress-nginx-docker-compose.svg?branch=master)](https://travis-ci.org/urre/wordpress-nginx-docker-compose)

Use WordPress with Docker using [Docker compose](https://docs.docker.com/compose/)

+ `Dockerfile` for extending a base image and install wp-cli
+ Local domain ex `myapp.local`
+ Custom nginx config in `./nginx`
+ Custom `php.ini` config in `./config`
+ Volumes for `nginx`, `wordpress` and `mariadb`
+ WordPress using [Bedrock](https://roots.io/bedrock/) - modern development tools, easier configuration, and an improved folder structure
+ CLI scripts for creating a self signed SSL certificate for using https locally, trusting certs and seting up the host file

## Setup

### Requirements

Install [Docker](https://www.docker.com/get-started)

### Create SSL cert

```shell
cd cli && ./create-cert.sh
```

### Trust cert in macOS Keychain. (Chrome and Safari will trust the certs, for Firefox: add them in preferences)

```shell
cd cli && ./trust-cert.sh
```

### Setup vhost in /etc/hosts

```shell
cd cli && ./setup-hosts-file.sh
```
> Follow the instructions. Use `myapp.local`

### Setup ENV

```shell
cd src
cp .env.example .env
```

> Use the following db settings:

```yml
DB_HOST=mysql:3306
DB_NAME=myapp
DB_USER=root
DB_PASSWORD=password
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

> Note: Use `docker-compose up -d --force-recreate --build` when you make changes to the `Dockerfile`

🚀 Open up [https://myapp.local](https://myapp.local)

> To specify your local domain, change in`./nginx/wordpress_ssl.conf` and in `./src/env`. Also change in the scripts in the `cli` folder

### Tools

Login to the docker container

```shell
docker exec -it myapp-wordpress bash
```

Ex. Use wp-cli

```
docker exec -it myapp-wordpress bash
wp plugin install wordpress-seo --allow-root
```

#### Useful Docker Commands

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
