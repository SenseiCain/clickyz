require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do

    if session[:user_id]
      @user = current_user
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
    register(params)

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

  helpers do 
    #register, logout
    def current_user
      User.find(session[:user_id])
    end

    def logout
      session.clear
    end

    def register(params)
      #binding.pry
      @user = User.new(name: params["name"], email: params["email"], password: params["password"])
      @user.save
      @user
    end
  end

end
