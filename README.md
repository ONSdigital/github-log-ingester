# GitHub Audit Log Ingester
This repository contains a Ruby [Sinatra](http://sinatrarb.com/) application that receives a GitHub audit log export JSON file and outputs its contents to STDOUT so it can be ingested by monitoring and management software.

## Installation
* Ensure that [Ruby](https://www.ruby-lang.org/en/downloads/) is installed
* Install [Bundler](https://bundler.io/) using `gem install bundler`
* Install the RubyGems this application depends on using `bundle install`

## Running
To run the application use `bundle exec rackup` and access using [http://localhost:9292](http://localhost:9292)

## Docker
Build using `docker build -t github-log-ingester .` and run using `docker run --rm --name github-log-ingester -d -p 80:3000 github-log-ingester`

## Copyright
Copyright (C) 2019 Crown Copyright (Office for National Statistics)