FROM ruby:2.3.3

RUN mkdir /malproksimo
WORKDIR /malproksimo

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install

ADD . /malproksimo

