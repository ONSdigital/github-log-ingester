FROM ruby:2.6.3

WORKDIR /usr/src/app
COPY . ./
RUN gem install bundler --no-document && bundle install

RUN addgroup --gid 1000 sinatra && \
    adduser --system --no-create-home --uid 1000 --gid 1000 sinatra && \
    chown -R sinatra:sinatra ./
USER sinatra

CMD ["bundle", "exec", "puma", "config.ru", "-C", "puma.rb"]
