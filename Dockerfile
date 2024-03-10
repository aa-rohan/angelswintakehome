FROM ruby:3.0.0

WORKDIR /awtestapp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . /awtestapp

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]