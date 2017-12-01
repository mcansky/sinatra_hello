FROM mcansky/base_ruby:2c7652fa95a2ab9419bb85e81a7c801ca6fa65d2

# Set environment variables.
ENV HOME /var/app
ENV RACK_ENV production

# Define working directory.
ADD . /var/app

RUN cd /var/app; bundle install

CMD ["./var/app/bin/http"]
