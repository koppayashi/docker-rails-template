FROM ruby:2.5.1-alpine as builder

ENV APP_ROOT /app

RUN mkdir -p $APP_ROOT && \
    apk upgrade --no-cache && \
    apk add --update --no-cache --virtual build-dependencies \
    build-base \
    curl-dev \
    linux-headers \
    libxml2-dev \
    libxslt-dev \
    mysql-dev \
    git && \
    gem install bundler --no-document

WORKDIR $APP_ROOT
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN echo 'install: --no-document' > ~/.gemrc && \
    echo 'update: --no-document' >> ~/.gemrc && \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install -j4 && \
    apk del --purge build-dependencies

FROM ruby:2.5.1-alpine

ARG RAILS_ENV="development"

ENV LANG ja-JP.UTF-8
ENV APP_ROOT /app

RUN mkdir -p $APP_ROOT && \
    apk upgrade --no-cache && \
    apk add --update --no-cache \
    libxml2-dev \
    libxslt-dev \
    mariadb-dev \
    zlib-dev \
    tzdata \
    nodejs \
    ca-certificates && \
    rm -rf /usr/lib/libmysqld* && \
    apk del --purge mariadb-client-libs mariadb-common && \
    gem install bundler --no-document

WORKDIR $APP_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . $APP_ROOT

RUN if [ $RAILS_ENV != "development" ]; then RAILS_ENV=$RAILS_ENV bundle exec rails assets:precompile --trace; fi

VOLUME ["/app/public", "/app/tmp"]

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
