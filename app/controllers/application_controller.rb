require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :editor
  end

  get "/orders" do
    erb :orders
  end

  get "/information" do
    erb :information
  end

end
