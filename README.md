# docker-mysql 
Dockerfile for mysql docker image

## Build mysql docker image
```
git clone git@github.com:eg5846/docker-mysql.git
cd docker-mysql
sudo docker pull eg5846/ubuntu:xenial
sudo docker build -t eg5846/mysql .
sudo docker push eg5846/mysql
```

## Run mysql docker container
```
# With database files stored inside the docker container
sudo docker run -d --restart=always -P -e MYSQL_ROOT_PASSWORD=root --name mysql eg5846/mysql

# With database files stored outside the docker container on the docker host (deprecated)
mkdir -p /export/docker/mysql/mysql
sudo docker run -d --restart=always -P -e MYSQL_ROOT_PASSWORD=root -v /export/docker/mysql/mysql:/var/lib/mysql --name mysql eg5846/mysql

# With database files stored outside the docker container in a volume container
sudo docker create --name mysql_vol eg5846/mysql /bin/false
sudo docker run -d --restart=always -P -e MYSQL_ROOT_PASSWORD=root --volumes-from=mysql_vol --name mysql eg5846/mysql
```
If MYSQL_ROOT_PASSWORD is not set, default value 'root' is used.

## Connect to database
```
sudo docker run --rm -it --link mysql:mysql eg5846/mysql /bin/bash -c 'mysql -u root -p -h $MYSQL_PORT_3306_TCP_ADDR -P $MYSQL_PORT_3306_TCP_PORT'
```
