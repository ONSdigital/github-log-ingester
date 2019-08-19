FROM ruby:2.5

WORKDIR /usr/src/app
COPY . ./
RUN gem install bundler --no-document && bundle install

USER 1000
CMD ["puma", "config.ru", "-C", "puma.rb"]
