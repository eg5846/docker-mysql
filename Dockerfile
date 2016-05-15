FROM eg5846/ubuntu:xenial
MAINTAINER Andreas Egner <andreas.egner@web.de>

# Install packages
RUN \
  apt-get install -y --no-install-recommends mysql-client mysql-server && \
  apt-get clean

# Remove preinstalled databases
RUN rm -rf /var/lib/mysql/*

# Add MySQL configuration
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Add MySQL scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME /var/lib/mysql

EXPOSE 3306
CMD ["/run.sh"]
