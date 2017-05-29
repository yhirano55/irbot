FROM ruby:latest

ENV APP_HOME /app
ENV DOCKER_VERSION 1.6.0

RUN apt-get update && \
    rm -rf /var/lib/apt/lists/*

RUN gem update --system && \
    gem update bundler

RUN wget -O /bin/docker https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}
RUN chmod +x /bin/docker
RUN gem update bundler

WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock

RUN export LANG=C.UTF-8 && \
    bundle install -j3

ADD . $APP_HOME
