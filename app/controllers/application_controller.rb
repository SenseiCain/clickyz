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
    if !session[:keyboard_data].values[0].nil?
      create_build(session[:keyboard_data])
      session[:keyboard_data].clear
    end

    @builds = current_user.builds
    #binding.pry

    erb :builds
  end

  post "/builds" do

    if session[:user_id]
      create_build(params)
      redirect to '/builds'
    else
      session[:keyboard_data] = params
      redirect to '/login'
    end
    
    
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

    if session[:keyboard_data]
      redirect to "/builds"
    else
      redirect to "/"
    end
  end

  post "/sessions" do
    user = User.find_by(:email => params["email"])

    if session[:keyboard_data]
      if user && user.authenticate(params["password"])
        session[:user_id] = user.id
        redirect to "/builds"
      else
        redirect to "/login"
      end
    else
      if user && user.authenticate(params["password"])
        session[:user_id] = user.id
        redirect to "/"
      else
        redirect to "/login"
      end
    end

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

    def create_build(params)
      build = Build.create(name: params["keyboard_name"], keycaps: params["keycaps"], case: params["case"], cable: params["cable"])
      build.user = current_user
      build.save
    end
  end

end
