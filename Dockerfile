FROM ubuntu:16.10
RUN apt-get update && apt-get install -y \
  apache2 \
  ruby \
  libapache2-mod-passenger \
  libapache2-mod-xsendfile \
  git \
  bundler \
  libmysqlclient-dev \
  nodejs-legacy
COPY . /var/www/onebody
COPY build/apache.conf /etc/apache2/sites-available/000-default.conf
RUN chmod +w log/production.log
WORKDIR /var/www/onebody
RUN bundle install --deployment && \
  mkdir -p tmp log public/system && \
  sudo chmod -R 777 tmp log public/system
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
