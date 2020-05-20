require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "custom_keebs"
      set :root, File.dirname(__FILE__)
    end
  

  get "/" do
    erb :index
  end

end
