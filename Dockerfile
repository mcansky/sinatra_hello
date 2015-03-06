FROM mcansky/ruby_base

# Set environment variables.
ENV HOME /var/app
ENV PORT 80
ENV RACK_ENV production

# Define working directory.
WORKDIR /var/app

RUN git clone https://github.com/mcansky/sinatra_hello.git /var/app
RUN cd /var/app; bundle install

EXPOSE 80
CMD ["/usr/local/bin/foreman","start","-d","/var/app"]
