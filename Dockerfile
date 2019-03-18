FROM woohuiren/php-laravel-env
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

ADD . "$(pwd)"

RUN apt-get update \
    && apt-get --yes --force-yes install apt-transport-https

RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx \
    && mv cf /usr/local/bin \
    && cf --version

RUN cf install-plugin ./scheduler-for-pcf-cliplugin-linux64-binary-1.1.0 -f \
    && rm -rf ./scheduler-for-pcf-cliplugin-linux64-binary-1.1.0

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN cf install-plugin https://github.com/odlp/antifreeze/releases/download/v0.4.0/antifreeze-linux -f