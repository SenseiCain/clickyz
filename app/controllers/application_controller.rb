require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    @user = User.find(session[:id])

    erb :editor
  end

  get "/orders" do
    erb :orders
  end

  get "/information" do
    erb :information
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save

    session[:id] = @user.id

    redirect to "/"
  end

end
