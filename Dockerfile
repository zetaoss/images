# https://github.com/wikimedia/mediawiki-docker
FROM mediawiki:1.39.10-fpm-alpine
ARG MEDIAWIKI_BRANCH=REL1_39

RUN set -eux \
    && apk add --no-cache \
    autoconf \
    build-base \
    libzip-dev \
    lua5.1 \
    nginx \
    tini \
    && docker-php-ext-install zip \
    && pecl install \
    redis \
    && docker-php-ext-enable \
    redis \
    && rm -rf /tmp/pear/ \
    && cd /var/www/html/extensions/ \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/AntiSpoof.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/CheckUser.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/CharInsert.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/intersection.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/MsUpload.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/OAuth.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/Score.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/SendGrid.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/UserMerge.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/Widgets.git \
    && git clone --depth=1 -b $MEDIAWIKI_BRANCH https://gerrit.wikimedia.org/r/mediawiki/extensions/Wikibase.git \
    && git clone --depth=1 -b v0.13.0           https://github.com/edwardspec/mediawiki-aws-s3.git                     AWS \
    && git clone --depth=1 -b v3.4.2            https://github.com/StarCitizenWiki/mediawiki-extensions-EmbedVideo.git EmbedVideo \
    && echo done
