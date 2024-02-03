# syntax=docker/dockerfile:experimental
FROM ruby:3.1.2-alpine

ENV BUNDLER_VERSION=2.4.3

RUN apk add --update --no-cache \
    build-base \
    file \
    openssh-client \
    libxml2-dev \
    libxslt-dev \
    make \
    openssl \
    mysql-dev \
    tzdata \
    python3 \
    shared-mime-info \
    gcompat

RUN gem install bundler -v ${BUNDLER_VERSION}

WORKDIR /app

# Install MySQL and Nokogiri gem before we add Gemfile.
# This allows us to cache this step regardless of a changed Gemfile.
RUN gem install nokogiri -v '1.13.10' -- --use-system-libraries
# MySQL is required for mysql2 gem to install
RUN gem install mysql2 -v '0.5.4' -- \
    --with-ldflags=-L/usr/local/opt/openssl/lib \
    --with-cppflags=-I/usr/local/opt/openssl/include

# Bundle install
COPY Gemfile Gemfile.lock ./

# Running bundle install using experimental --mount option to forward ssh agent
RUN bundle check || bundle install --jobs 4 --retry 5

COPY . ./
