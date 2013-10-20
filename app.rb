require 'rubygems'
require 'sinatra'
require 'ostruct'
require 'time'

require 'sinatra/base'
require "sinatra/reloader"
require 'sinatra/assetpack'
require 'sass'
require 'coffee-script'
require './github_hook'

class App < Sinatra::Base
  use GithubHook

  # Set sinatra's variables
  set :app_file, __FILE__
  set :root, File.dirname(__FILE__) # you have to set app root
  set :views, "views"
  # set :public_dir, "static" # if you had a folder other than 'public'

  register Sinatra::AssetPack

  configure :development do
    register Sinatra::Reloader
    set :scss, { :style => :expanded }
    # set :scss, {:style => :nested}
    # set :scss, {:style => :compressed}
    # set :scss, {:style => :compact}
  end

  assets {
    serve '/js',      from: 'assets/js' # default
    serve '/css',     from: 'assets/css' # default
    serve '/images',  from: 'assets/images' # default

    # The 2nd parameter defines where the compressed version will be served.
    # Note: that 2nd param is optional, AssetPack will figure it out.

    js :app, '/js/app.js', [
      '/js/vendor/**/*.js',
      '/js/ilb/**/*.js'
    ]

    css :application, '/css/application.css', [
      '/css/normalize.css',
      '/css/app.css',
      '/css/main.css'
    ]

    js_compression  :js_compression  # :jsmin | :yui | :closure | :uglify

    # you can tweak the output_settings if you use configure
    # css_compression :simple  # :simple | :sass | :yui | :sqwish
    # css_compression :sass
  }

  get '/' do
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end