require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "custom_keebs"
  end

  get "/" do
    erb :editor
  end

  get "/information" do
    #Future functionality - RESTful pages that show info on cases/switches/keycaps
    erb :information
  end

end
