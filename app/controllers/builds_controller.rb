require 'google/cloud/storage'

class BuildController < ApplicationController

    configure do
        set :public_folder, 'public'
      end

    get "/builds" do
        if session[:user_id]
            @builds = current_user.builds
            erb :builds
        else
            redirect to '/'
        end
    end

    post "/builds" do
        if session[:user_id]
            session.delete(:keyboard_data)

            tempfile_name = "#{SecureRandom.hex(10)}-build.png"
            upload_image_to_google(tempfile_name)
            Build.create_with_jpg(params, current_user, tempfile_name)

            redirect to '/builds'
        else
            session[:keyboard_data] = params.except("image_data")
            redirect to '/login'
        end
    end

    get "/builds/:id/edit" do
        @build = getBuild(params)
        redirect_if_not_authorized(@build)
        erb :edit
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
            Build.find(params[:id])
        end

        def redirect_if_not_authorized(build)
            if !session[:user_id] || !current_user.builds.include?(build)
              redirect to '/builds'
            end
        end

        def upload_image_to_google(filename)
            storage = Google::Cloud::Storage.new(
                project_id: "youtubesearch-167217",
                credentials: "/Users/christiancain/Desktop/Flatiron/projects/clickyz/youtubesearch-167217-28e69b8eb833.json"
            )

            bucket  = storage.bucket "clickyz-builds"
            tempfile = Tempfile.new(['image', '.png'], binmode: true)
            tempfile.write(Base64.decode64(params[:image_data].remove("data:image/png;base64,")))
            bucket.create_file tempfile.path, filename
        end
    end
end