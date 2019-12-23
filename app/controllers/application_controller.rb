require './config/environment'
require_relative '../helpers/controller_helpers'

class ApplicationController < Sinatra::Base

  helpers ControllerHelpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do

    if session[:user_id]
      @user = User.find(session[:user_id])
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

  post "/register" do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save

    session[:user_id] = @user.id

    redirect to "/"
  end

  post "/sessions" do

    #if valid user, go to editor. else login.





    redirect to "/"
  end

  get "/logout" do
    logout

    redirect to "/"
  end


end
