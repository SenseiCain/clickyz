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
        build.update_with_jpg(params)

        redirect to '/builds'
    end

    delete "/builds/:id" do
        build = getBuild(params)

        redirect_if_not_authorized(build)

        build.delete_with_jpg

        redirect to '/builds'
    end

    helpers do
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
    end
end