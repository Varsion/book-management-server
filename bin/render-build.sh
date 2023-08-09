#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake db:migrate
# just run once
bundle exec rake db:seed