# MySQL Docker

This repository contains the source code for building a MySQL Docker image based on the [original image](https://github.com/docker-library/mysql), modified with the [recommended configurations](http://opaldoc.obiba.org/en/latest/web-user-guide/administration/databases.html#id1) for the [Opal](https://www.obiba.org/pages/products/opal/) application.

## Building
After every commit, GitLab CI automatically builds the image and pushes it into INESC TEC's Docker Registry. The version tag of the image is determined from a string matching `##x.x.x##` on the commit message.

Alternatively, an image can be built locally by running:
`docker build -t mysql-docker .`

## Setting Up
**Environment Variables**  
The following environment variables are required:

* `MYSQL_DATABASE` is the name of the database to be created on startup;
* `MYSQL_USER` and `MYSQL_PASSWORD` are used to create a new user who will be granted superuser permissions for the database specified in `MYSQL_DATABASE`;
* `MYSQL_ROOT_PASSWORD` will be used to set the password for the MySQL root superuser account.

If you are using Docker Swarm, you can instead set the following variables to enable Docker secrets:
* `MYSQL_PASSWORD_FILE` and `MYSQL_ROOT_PASSWORD_FILE`

**Volumes**  
To persist the data across executions, you can mount `/var/lib/mysql` as a volume.

## Running

Create a `docker-compose.yml` file (examples bellow) and run `docker-compuse up`.

**Basic Example:**
```yml
version: '3.2'

services:
  mysql:
    image: docker-registry.inesctec.pt/coral/coral-docker-images/coral-mysql-docker:1.1.0
    container_name: mysql
    environment:
    - MYSQL_DATABASE=<INSERT_VALUE_HERE>
    - MYSQL_USER=<INSERT_VALUE_HERE>
    - MYSQL_PASSWORD=<INSERT_VALUE_HERE>
    - MYSQL_ROOT_PASSWORD=<INSERT_VALUE_HERE>
    volumes:
    - mysql:/var/lib/mysql

volumes:
  mysql:
```
**Docker Swarm Example:**
```yml
version: '3.2'

services:
  mysql:
    image: docker-registry.inesctec.pt/coral/coral-docker-images/coral-mysql-docker:1.1.0
    container_name: mysql
    environment:
    - MYSQL_DATABASE=<INSERT_VALUE_HERE>
    - MYSQL_USER=<INSERT_VALUE_HERE>
    - MYSQL_PASSWORD_FILE=/run/secrets/MYSQLIDS_PASSWORD
    - MYSQL_ROOT_PASSWORD_FILE=/run/secrets/MYSQLIDS_ROOT_PASSWORD
    secrets:
    - MYSQL_PASSWORD
    - MYSQL_ROOT_PASSWORD
    volumes:
    - mysql:/var/lib/mysql

secrets:
  MYSQL_PASSWORD:
    external: true
  MYSQL_ROOT_PASSWORD:
    external: true

volumes:
  mysql:
```

<br>

---
master: [![pipeline status](https://gitlab.inesctec.pt/coral/coral-docker-images/coral-mysql-docker/badges/master/pipeline.svg)](https://gitlab.inesctec.pt/coral/coral-docker-images/coral-mysql-docker/commits/master)

dev: &emsp;&ensp;[![pipeline status](https://gitlab.inesctec.pt/coral/coral-docker-images/coral-mysql-docker/badges/dev/pipeline.svg)](https://gitlab.inesctec.pt/coral/coral-docker-images/coral-mysql-docker/commits/dev)
