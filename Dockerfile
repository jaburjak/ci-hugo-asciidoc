FROM rust:bookworm

RUN apt-get update; \
  apt-get install -y make protobuf-compiler

COPY asciidoctor-server /usr/local/asciidoctor-server

RUN cd /usr/local/asciidoctor-server; \
  make client

FROM debian:bookworm

COPY Gemfile Gemfile.lock /usr/local/bundle/

RUN apt-get update

RUN apt-get install -y curl tar zip unzip jq patch

RUN curl -fsSL 'https://deb.nodesource.com/setup_22.x' -o nodesource_setup.sh; \
  bash nodesource_setup.sh; \
  apt-get install -y nodejs

RUN apt-get install -y ruby-full; \
  gem install bundler; \
  cd /usr/local/bundle; \
  bundle install

RUN apt-get install -y make procps

COPY --from=0 /usr/local/bin/asciidoctor-client /usr/local/bin/asciidoctor-client

COPY asciidoctor-server /usr/local/asciidoctor-server

RUN cd /usr/local/asciidoctor-server; \
  make server; \
  echo '#!/bin/bash' > /usr/local/sbin/asciidoctor; \
  echo 'exec asciidoctor-client --address unix:/tmp/asciidoctor-server.sock --max-timeout 1 --max-retries 30 "${@:1:$#-1}" stdin' >> /usr/local/sbin/asciidoctor; \
  chmod g+x,o+x /usr/local/sbin/asciidoctor; \
  echo '#!/bin/bash' > /usr/local/sbin/hugo; \
  echo 'set -e' >> /usr/local/sbin/hugo; \
  echo 'asciidoctor-server --address unix:/tmp/asciidoctor-server.sock -t 5 >/dev/null 2>&1 &' >> /usr/local/sbin/hugo; \
  echo 'set +e' >> /usr/local/sbin/hugo; \
  echo '/usr/local/bin/hugo "$@"' >> /usr/local/sbin/hugo; \
  echo 'exitcode=$?' >> /usr/local/sbin/hugo; \
  echo 'kill -9 $(pgrep -f asciidoctor-server)' >> /usr/local/sbin/hugo; \
  echo 'if [ -f /tmp/asciidoctor-server.sock ]; then rm /tmp/asciidoctor-server.sock; fi' >> /usr/local/sbin/hugo; \
  echo 'exit $exitcode' >> /usr/local/sbin/hugo; \
  chmod g+x,o+x /usr/local/sbin/hugo

COPY scripts/asciidoctor/* /usr/local/scripts/asciidoctor/

RUN cd /usr/local/scripts/asciidoctor/; \
  find . -type f -name '*.sh' | sh

RUN apt-get install -y perl-modules pdf2svg; \
  curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
  zcat < install-tl-unx.tar.gz | tar xf -; \
  cd install-tl-*; \
  perl ./install-tl --no-interaction --scheme=scheme-basic --no-doc-install --no-src-install; \
  ln -s "$(ls /usr/local/texlive | head -n1)/bin/x86_64-linux" /usr/local/texlive/bin

ENV PATH="$PATH:/usr/local/texlive/bin"

RUN tlmgr install pgf standalone

RUN apt-get install -y inotify-tools

RUN curl -fsSL 'https://github.com/gohugoio/hugo/releases/download/v0.140.0/hugo_extended_0.140.0_linux-amd64.deb' -o hugo.deb; \
  dpkg -i hugo.deb

RUN rm -rf /usr/local/scripts; \
  rm -rf /usr/local/asciidoctor-server; \
  rm /nodesource_setup.sh /hugo.deb; \
  rm -rf /install-tl-*