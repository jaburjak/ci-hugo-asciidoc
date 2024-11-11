FROM debian:bookworm

RUN apt-get update

RUN apt-get install -y curl tar zip unzip jq

RUN curl -fsSL 'https://deb.nodesource.com/setup_22.x' -o nodesource_setup.sh; \
  bash nodesource_setup.sh; \
  apt-get install -y nodejs

RUN apt-get install -y ruby-full; \
  gem install bundler

RUN apt-get install -y texlive pdf2svg

RUN curl -fsSL 'https://github.com/gohugoio/hugo/releases/download/v0.138.0/hugo_extended_0.138.0_linux-amd64.deb' -o hugo.deb; \
  dpkg -i hugo.deb