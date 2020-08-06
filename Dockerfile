FROM instructure/ruby:2.6

USER root

ENV WORKDIR /usr/src/app
RUN mkdir -p tmp/spec-results
RUN chown -R docker $WORKDIR

COPY --chown=docker:docker Gemfile Gemfile.lock ./

USER docker
RUN bundle install --quiet --jobs 8
USER root

COPY --chown=docker:docker . ./

USER docker
