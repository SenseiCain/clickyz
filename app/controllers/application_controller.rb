require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do

    @session = session

    if session[:id]
      
      @user = User.find(session[:id])
    end

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

  get "/logout" do
    session.clear

    redirect to "/"
  end

end
