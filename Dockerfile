FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /test_unl
WORKDIR /test_unl
COPY Gemfile /test_unl/Gemfile
COPY Gemfile.lock /test_unl/Gemfile.lock
RUN bundle install
COPY . /test_unl

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]