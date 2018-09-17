FROM ubuntu:bionic
MAINTAINER Andreas Egner <andreas.egner@web.de>

# Install packages
RUN \
  apt-get update && \
  apt-get dist-upgrade -y && \
  apt-get install -y --no-install-recommends mysql-client mysql-server && \
  apt-get clean

# Remove preinstalled databases
RUN rm -rf /var/lib/mysql/*

# Add MySQL configuration
ADD mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Add MySQL scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME /var/lib/mysql

EXPOSE 3306
CMD ["/run.sh"]
