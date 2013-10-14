require 'bundler'
Bundler.require

# thin is messed up, if you have default it will use it.
# Bundler.require(:default)

# require './app'
require File.expand_path '../app.rb', __FILE__

run App