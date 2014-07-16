FROM ubuntu:trusty
MAINTAINER Andreas Egner <andreas.egner@web.de>

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Modify inputrc
RUN \
  sed -i 's/^#\s*\(.*history-search-backward\)$/\1/g' /etc/inputrc && \
  sed -i 's/^#\s*\(.*history-search-forward\)$/\1/g' /etc/inputrc

# Replace sources.list for apt
ADD sources.list /etc/apt/sources.list

# Upgrade system
RUN \
  apt-get update && \
  apt-get dist-upgrade -y --no-install-recommends && \
  apt-get autoremove -y && \
  apt-get clean

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
