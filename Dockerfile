

from ubuntu:trusty


maintainer Teemu Heikkilä

RUN apt-get update
RUN apt-get install -y zlib1g-dev libc6-dev libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make
RUN apt-get install -y wget
RUN wget http://openresty.org/download/ngx_openresty-1.7.7.2.tar.gz
RUN tar -xzvf ngx_openresty-1.7.7.2.tar.gz
WORKDIR ngx_openresty-1.7.7.2
RUN ./configure
RUN make -j2
RUN make install
RUN apt-get install -y redis-server
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD shorten.lua /usr/local/openresty/nginx/conf/shorten.lua
ADD redirect.lua /usr/local/openresty/nginx/conf/redirect.lua

RUN /usr/local/openresty/nginx/sbin/nginx -t
EXPOSE 80
CMD ["/usr/bin/supervisord"]