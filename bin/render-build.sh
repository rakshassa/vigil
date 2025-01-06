#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bin/rails db:environment:set RAILS_ENV=production
bundle exec rake assets:precompile
bundle exec rake assets:clean

# If you're using a Free instance type, you need to
# perform database migrations in the build command.
# Uncomment the following line:

bundle exec rake db:drop db:create db:migrate db:seed
