FROM ruby:2.5.0

ENV APP_ROOT /usr/src/project_name/

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    bundle config --global build.nokogiri --use-system-libraries && \
    bundle config --global jobs 4 && \
    bundle install && \
    rm -rf ~/.gem

COPY . $APP_ROOT

#EXPOSE 3000
#CMD ["rails", "server", "-b", "0.0.0.0"]
