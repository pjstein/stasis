#
# Stasis::site.com
#

server {
  listen 80 deferred;

  # Redirection and balancing is handled at a higher level.
  server_name localhost;

  # Descendent containers ought to place their static assets here:
  root /site/public;

  # Specify a character set.
  charset utf-8;

  # On the off chance that someone would like to serve up mysite.com/404.html
  # place the site's custom 404 page here:
  error_page 404 /site/404.html;

  # The basic h5bp configuration is grand.
  include h5bp/basic.conf;

  # But caches aggressively. When developing client driven applications, name
  # javascript and css assets uniquely during builds and point the index at
  # those files. Use the timestamp. If after building, you do not see changes,
  # wait one millisecond, and try building again.
  #
  # If that solution repels you, the following ought to override h5bp's basic
  # configuration:
  #
  # location ~* \.(?:css|js)$ {
  #   expires -1;
  # }
}


