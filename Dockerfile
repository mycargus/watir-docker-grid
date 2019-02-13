FROM instructure/ruby:2.6

USER root

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME/tmp/spec-results
RUN chown -R docker $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./

USER docker
RUN bundle install --quiet --jobs 8
USER root

COPY --chown=docker:docker . ./

USER docker
