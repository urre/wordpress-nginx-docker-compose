
# Docker Compose and WordPress

Simple Docker Compose setup for running WordPress

+ [Docker compose](https://docs.docker.com/compose/)
+ Use a local domain ex `myapp.local`
+ Custom nginx confif
+ Using a self signed SSL certificate for using https locally
+ Using Roots Bedrock in this example (optional)

## Setup

### Create SSL cert

  cd cli && ./create-cert.sh

### Trust cert in macOS Keychain

  cd cli && ./trust-cert.sh

### Setup vhost in /etc/hosts

  cd cli && ./setup-hosts-file.sh

## Run

  docker-compose up -d

### Tools

#### Composer

Use composer like this:

  docker-compose run composer show
  docker-compose run composer update
  docker-compose run composer create-project roots/bedrock .

#### Useful Docker Commands

List containers

	docker-compose ps

Stop

	docker-compose stop

Down (stop and remove)

	docker-compose down

Cleanup

  docker-compose rm -v

	docker-compose up -d --force-recreate

List all containers

	docker ps

List all images

	docker image ls
