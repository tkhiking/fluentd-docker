FROM fluent/fluentd:v1.11-debian-1

USER root

RUN buildDeps="sudo make gcc g++ libc-dev libffi-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install fluent-plugin-s3 -v 1.3.2 --no-document \
 && sudo gem install fluent-plugin-grafana-loki -v 1.2.12 --no-document \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
