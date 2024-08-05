# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:3.2.4 AS rails-toolbox

RUN apt-get update && apt-get install -y \
  nodejs \
  yarn \
  libpq-dev \
  python3-distutils \
  build-essential \
  curl

# Install production dependencies.
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install

# Copy local code to the container image.
COPY . .

RUN chmod +x /app/bin/rails


ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

# Ensure secrets and keys are set correctly
ENV SECRET_KEY_BASE=a0729bca404c7f7650cd10bca6767110f6318584adc4168d058730083d1dc3c802dcb4273e2bf09af43fb5d9dc35b969392b3503af260885a62de5dff2d22c00

# Precompile assets
RUN bundle exec rake assets:precompile

# Database setup
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
RUN bundle exec rake db:seed

EXPOSE 8080

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]
