FROM ubuntu:14.04

# Install packages for building ruby
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y --force-yes build-essential curl wget git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev ruby2.1 ruby2.1-dev
RUN apt-get clean
RUN gem install bundler foreman
RUN mkdir -p /var/app

# Set environment variables.
ENV HOME /var/app
ENV PORT 3000
ENV RACK_ENV production

# Define working directory.
WORKDIR /var/app

RUN git clone https://github.com/mcansky/sinatra_hello.git /var/app
RUN cd /var/app; bundle install

EXPOSE 80
CMD ["/usr/local/bin/foreman","start","-d","/var/app"]
