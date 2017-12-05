FROM ruby:2.3.5-slim

RUN apt-get update && apt-get install -y build-essential libffi-dev libgdbm-dev libncurses5-dev libreadline-dev libssl-dev libyaml-dev zlib1g-dev curl libyaml-0-2 libxml2-dev libxslt-dev
#RUN apk --update add --virtual openssl-dev build-dependencies ruby-dev build-base

# Set environment variables.
ENV HOME /var/app
ENV RACK_ENV production
# Define working directory.
ADD . /var/app
RUN cd /var/app; bundle install --without development test

CMD ["./var/app/bin/http"]
