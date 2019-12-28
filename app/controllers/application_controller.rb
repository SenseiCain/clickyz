require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "custom_keebs"
  end

  get "/" do

    if session[:user_id]
      @user = current_user
    end

    erb :editor
  end

  get "/builds" do
    #build out builds based on user id
    @builds = current_user.builds
    #binding.pry

    erb :builds
  end

  post "/builds" do
    puts params
    create_build(params)
    
    redirect to '/builds'
  end

  get "/information" do
    #RESTful pages that show info on cases/switches/keycaps
    erb :information
  end

  get "/login" do
    erb :login
  end

  post "/register" do
    @user = register(params)
    session[:user_id] = @user.id

    redirect to "/"
  end

  post "/sessions" do
    login(params)
  end

  get "/logout" do
    logout

    redirect to "/"
  end

  helpers do 
    def current_user
      current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logout
      session.clear
    end

    def register(params)
      User.create(username: params["username"], email: params["email"], password: params["password"])
    end

    def login(params)
      user = User.find_by(:email => params["email"])

      if user && user.authenticate(params["password"])
        session[:user_id] = user.id
        redirect to "/"
      else
        redirect to "/login"
      end
    end

    def create_build(params)
      build = Build.create(name: params["keyboard_name"], keycaps: params["keycaps"], case: params["case"], cable: params["cable"])
      build.user = current_user
      build.save
      #binding.pry
    end
  end

end
