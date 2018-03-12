FROM richarvey/nginx-php-fpm:latest

MAINTAINER phprush "jjy0712@163.com"

#Install PHP extensions phalcon
ENV PHALCON_VERSION=3.3.1

RUN echo 'date.timezone = "Asia/Shanghai"' > /usr/local/etc/php/conf.d/docker-vars.ini

RUN curl -s -L https://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHALCON_VERSION} | tar -xvzf - -C /tmp \
  && cd /tmp/cphalcon-${PHALCON_VERSION}/build && ./install \
  && docker-php-ext-enable phalcon \
  && cd /tmp && rm -r /tmp/cphalcon-${PHALCON_VERSION} 

ADD . /var/www/website/

ADD ./deploy/nginx-phalcon.conf /etc/nginx/conf.d/default.conf

CMD ["/start.sh"]

