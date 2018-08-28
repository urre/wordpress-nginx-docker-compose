
# Docker Compose and WordPress

Simple Docker Compose setup for running WordPress

+ [Docker compose](https://docs.docker.com/compose/)
+ Use a local domain ex `myapp.local`
+ Custom nginx confif
+ Using a self signed SSL certificate for using https locally
+ Using Roots Bedrock in this example (optional)

## Setup

### Create SSL cert

```shell
cd cli && ./create-cert.sh
```

### Trust cert in macOS Keychain

```shell
cd cli && ./trust-cert.sh
```

### Setup vhost in /etc/hosts

```shell
cd cli && ./setup-hosts-file.sh
```

## Run

```shell
docker-compose up -d
```

### Tools

#### Composer

Use composer like this:

```shell
  docker-compose run composer show
  docker-compose run composer update
  docker-compose run composer create-project roots/bedrock .
  ...
```

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
docker-compose up -d --force-recreate
```

List all containers

```shell
docker ps
```

List all images

```shell
docker image ls
```
