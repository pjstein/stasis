#
# Stasis::Dockerfile
#

FROM       ubuntu:14.04
MAINTAINER Peter James Stein 'me@pjstein.co'

# Add Nginx signing key and install Nginx
ADD nginx_signing.key /tmp/nginx_signing.key
RUN apt-key add /tmp/nginx_signing.key
RUN echo "deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx\n deb-src http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN apt-get update
RUN apt-get install -y nginx=1.6.0-1~$(lsb_release -cs)

# Add the 'www' user that Nginx will run as
RUN useradd www

# Nuke the stock Nginx configuration
RUN rm -rf /etc/nginx/*

# Configure Nginx using the H5BP recommended configuration
ADD server-configs-nginx/nginx.conf /etc/nginx/nginx.conf
ADD server-configs-nginx/mime.types /etc/nginx/mime.types
ADD server-configs-nginx/h5bp       /etc/nginx/h5bp

RUN mkdir /etc/nginx/sites-enabled

ADD site.com /etc/nginx/sites-enabled/site.com

# Fix up the nginx configuration
RUN sed -i 's/logs\/error.log/\/dev\/stderr/'  /etc/nginx/nginx.conf
RUN sed -i 's/logs\/access.log/\/dev\/stdout/' /etc/nginx/nginx.conf
RUN sed -i 's/logs\/static.log/\/dev\/stdout/' /etc/nginx/h5bp/location/expires.conf

RUN echo "daemon off;" >>  /etc/nginx/nginx.conf

# Make site directories
RUN mkdir /site/

# Expose ports 80 (HTTP) and 443 (HTTPS)
EXPOSE 80 443

CMD ["nginx"]
