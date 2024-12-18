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

RUN curl -fsSL 'https://github.com/gohugoio/hugo/releases/download/v0.140.0/hugo_extended_0.140.0_linux-amd64.deb' -o hugo.deb; \
  dpkg -i hugo.deb

