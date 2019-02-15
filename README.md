
# Docker Compose and WordPress

[Docker compose](https://docs.docker.com/compose/) setup for running WordPress

+ [Bedrock](https://roots.io/bedrock/) - modern development tools, easier configuration, and an improved folder structure
+ Docker and Docker compose.
+ Dockerfile for extending a base image and install wp-cli
+ Local domain ex `myapp.local`
+ Custom nginx config in `./nginx`
+ Self signed SSL certificate for using https locally

## Setup

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

### Setup ENV

```shell
cd src
cp .env-example .env
```

> Follow the instructions. Use `myapp.local`

## Run

```shell
docker-compose up -d
```

> Note: Use `docker-compose up -d --force-recreate --build` when you make changes to the `Dockerfile`

🚀 Open up [https://myapp.local](https://myapp.local)

> Notes: Copy `.env-example` to `.env` and update your credentials. Use your own local domain in `./nginx/wordpress_ssl.conf` and in `./src/env`.

### Tools

#### Composer

Use composer like this:

```shell
  docker-compose run composer show
  docker-compose run composer update
  docker-compose run composer create-project roots/bedrock .
  ...
```

> Notes: this project uses [Bedrock](https://github.com/roots/bedrock) is a WordPress boilerplate with modern development tools, easier configuration, and an improved folder structure. The wbb root in `./nginx/wordpress_ssl.conf` is `root /var/www/html/web;`

#### Useful Docker Commands

List containers

```shell
docker-compose ps
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

> Recreate using `docker-compose up -d --force-recreate`

List all containers

```shell
docker ps
```

List all images

```shell
docker image ls
```
