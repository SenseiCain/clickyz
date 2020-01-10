class BuildController < ApplicationController
    get "/builds" do

    if session[:user_id]
        @builds = current_user.builds
        erb :builds
    else
        redirect to '/'
    end
    end

    patch "/builds/:id" do

    build = Build.find(params[:id])

    redirect_if_not_authorized(build)

    #update obj
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
    build = Build.find(params[:id])

    redirect_if_not_authorized(build)

    File.delete('public/images/keyboard_saves/' + build.img_file.to_s)
    build.delete

    redirect to '/builds'
    end

    post "/builds" do

    if session[:user_id]
        @build = create_build(params)
        convert_svg_to_jpg(params, @build)
        session.delete(:keyboard_data)
        redirect to '/builds'
    else
        session[:keyboard_data] = params.except("svg")
        redirect to '/login'
    end
    
    end

    get "/edit" do
    @build = getBuild(params)

    redirect_if_not_authorized(@build)

    erb :edit_build
    end
end