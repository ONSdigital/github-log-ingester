FROM ruby:2.5

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
COPY app.rb config.ru ./
RUN gem install bundler --no-document && bundle install

CMD ["bundle", "exec", "rackup"]
