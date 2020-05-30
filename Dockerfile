FROM ruby:2.7.1-slim

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  libffi-dev \
  libgdbm-dev \
  libncurses5-dev \
  libreadline-dev \
  libssl-dev \
  libyaml-dev \
  zlib1g-dev \
  curl \
  libyaml-0-2 \
  libxml2-dev \
  libxslt-dev

# Set environment variables.
ENV HOME /var/app
ENV RACK_ENV production
# Define working directory.
ADD . /var/app
RUN bundle config set deployment 'true' \
  && bundle config set without 'development test'
RUN cd /var/app; bundle install

WORKDIR /var/app

CMD ["/bin/sh", "/var/app/bin/http"]
