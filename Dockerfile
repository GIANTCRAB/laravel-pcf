FROM woohuiren/php-laravel-env
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

RUN apt-get update \
    && apt-get --yes --force-yes install apt-transport-https

RUN curl --output cf_cli.deb -L https://cli.run.pivotal.io/stable?release=debian64&source=github \
    && dpkg -i ./cf_cli.deb \
    && apt-get --yes --force-yes install -f \
    && cf --version

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN cf install-plugin https://github.com/odlp/antifreeze/releases/download/v0.4.0/antifreeze-linux -f