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

    if session[:user_id]
      @builds = current_user.builds
      erb :builds
    else
      redirect to '/'
    end
  end

  patch "/builds/:id" do

    #update obj
    build = Build.find(params[:id])
    build.name = params[:keyboard_name]
    build.primary_color = params[:keycaps_primary]
    build.alt_color = params[:keycaps_alt]
    build.case = params[:case]
    build.cable = params[:cable]

    #update image
    delete_jpg(build)
    convert_svg_to_jpg(params, build)

    build.save

    redirect to '/builds'
  end

  delete "/builds/:id" do
    if session[:user_id] && current_user.builds.include?(Build.find(params[:id]))
      build = Build.find(params[:id])
      File.delete('public/images/keyboard_saves/' + build.img_file.to_s)
      build.delete
    end

    redirect to '/builds'
  end

  post "/builds" do

    if session[:user_id]
      @build = create_build(params)
      convert_svg_to_jpg(params, @build)
      redirect to '/builds'
    else
      redirect to '/login'
    end
    
  end

  get "/edit" do
    @build = getBuild(params)
    #binding.pry
    erb :edit_build
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
    user = User.find_by(:email => params["email"])

    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect to "/"
    else
      redirect to "/login"
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

    def getBuild(params)
      build = Build.find(params[:build_id])
      build
    end

    def create_build(params)
      build = Build.create(name: params["keyboard_name"], case: params["case"], cable: params["cable"], primary_color: params["keycaps_primary"], alt_color: params["keycaps_alt"])
      build.user = current_user
      build.save
      build
    end

    def delete_jpg(build)
      #binding.pry
      File.delete("public/images/keyboard_saves/#{build.img_file}")
    end

    def convert_svg_to_jpg(params, build)
      #generates svg as placeholder
      rand_num = rand(1000)
      filepath = "lib/temp_svgs/temp_svg_#{rand_num}.svg"
      temp_file = File.open(filepath, "w")  do |f| 
        text_2 = params[:svg] + '</svg>'
        text_2.slice! "<svg>"

        f.write(File.open('lib/svgs/metadata.txt', 'r').read)
        f.write(text_2)
      end

      #converts svg to jpg & save
      image = MiniMagick::Image.open(filepath)
      image.format "jpg"
      image.write "public/images/keyboard_saves/keyboard_#{rand_num}.jpg"

      #delete placeholder svg
      File.delete(filepath)

      #assign file to build
      build.img_file = "keyboard_#{rand_num}.jpg"
      build.save
    end
  end

end
