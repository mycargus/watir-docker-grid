FROM instructure/ruby:2.5

USER root

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME/tmp/spec-results
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/

USER docker
RUN bundle install --quiet --jobs 8
USER root

COPY --chown=docker:docker . $APP_HOME

USER docker
