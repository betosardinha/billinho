FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /billinho-api
WORKDIR /billinho-api

COPY Gemfile /billinho-api/Gemfile
COPY Gemfile.lock /billinho-api/Gemfile.lock

RUN gem install bundler:2.1.4

RUN bundle update --bundler

RUN bundle install

COPY . /billinho-api