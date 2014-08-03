# Stasis

Trying to wrap my head around Docker. It is both wonderful and great. I read
a [blog post](http://bricolage.io/hosting-static-sites-with-docker-and-nginx/)
about hosting static sites with Docker & Nginx. It seemed a good place to start.
I stole a bunch of code from that guy. Have mercy.

I've published this image to [pjstein/stasis](https://registry.hub.docker.com/u/pjstein/stasis/)
on the Docker registry.

## Usage

This image can serve as a base for containers that'd serve static content. The
`Dockerfile` for a project using this image looks like this:

    FROM pjstein/stasis

    ADD public /site/public
    CMD ["nginx"]

You can add a custom error page too:


    FROM pjstein/stasis

    ADD public   /site/public
    ADD 404.html /site/404.html

    CMD ["nginx"]

Magic.
