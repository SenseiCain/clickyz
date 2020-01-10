class BuildController < ApplicationController
    get "/builds" do
        if session[:user_id]
            @builds = current_user.builds
            erb :builds
        else
            redirect to '/'
        end
    end

    get "/edit" do
        @build = getBuild(params)

        redirect_if_not_authorized(@build)

        erb :edit_build
    end

    post "/builds" do
        if session[:user_id]
            #Move to Build Model - Create Build
            Build.create_with_jpg(params, current_user)
            session.delete(:keyboard_data)

            redirect to '/builds'
        else
            session[:keyboard_data] = params.except("svg")
            redirect to '/login'
        end
    end

    patch "/builds/:id" do
        build = getBuild(params)

        redirect_if_not_authorized(build)

        #Move to Build Model
        build.name = params[:keyboard_name]
        build.primary_color = params[:keycaps_primary]
        build.alt_color = params[:keycaps_alt]
        build.case = params[:case]
        build.cable = params[:cable]

        #Update Image
        delete_jpg(build)
        convert_svg_to_jpg(params, build)

        build.save

        redirect to '/builds'
    end

    delete "/builds/:id" do
        build = getBuild(params)

        redirect_if_not_authorized(build)

        #Move to Build Model
        delete_jpg(build)
        build.delete

        redirect to '/builds'
    end

    

    helpers do
        #Necessary
        def current_user
            current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

        def getBuild(params)
            build = Build.find(params[:id])
            build
        end

        def redirect_if_not_authorized(build)
            if !session[:user_id] || !current_user.builds.include?(build)
              redirect to '/builds'
            end
        end

        #Move these to Build Model
        
    
        

    end
end