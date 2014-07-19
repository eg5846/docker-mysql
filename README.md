# mysql docker image

## Build mysql docker image
```
git clone git@github.com:eg5846/mysql-docker.git
cd mysql-docker
sudo docker build -t eg5846/nginx-mysql .

# Pushing image to registry.hub.docker.com is no longer required!!!
# Image build is automatically initiated after pushing commits of project to github.com
# sudo docker push eg5846/mysql-docker
```

## Run mysql docker image (e.g. as mysqlsrv)
```
# With database files stored inside the docker container
sudo docker run -d -P -e MYSQL_ROOT_PASSWORD=root --name mysqlsrv eg5846/mysql-docker

# With database files stored outside the docker container on the docker host
mkdir -p /export/docker/mysqlsrv/mysql
sudo docker run -d -P -e MYSQL_ROOT_PASSWORD=root -v /export/docker/mysqlsrv/mysql:/var/lib/mysql --name mysqlsrv eg5846/mysql-docker
```
If MYSQL_ROOT_PASSWORD is not set, default value 'root' is used.

## Connect to database
```
sudo docker run --rm -it --link mysqlsrv:mysql eg5846/mysql-docker /bin/bash -c 'mysql -u root -p $MYSQL_ROOT_PASSWORD -h $MYSQL_PORT_3306_TCP_ADDR -P $MYSQL_PORT_3306_TCP_PORT'
```
