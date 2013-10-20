require 'bundler'
Bundler.require(:default)

require File.expand_path '../app.rb', __FILE__

# set :env, :production
# disable :run

run App