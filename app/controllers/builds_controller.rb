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

            filename = upload_image_to_google
            Build.create_with_img(params, current_user, filename)

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

        delete_previous_file_from_google(build.img_url)
        filename = upload_image_to_google
        build.update_with_img(params, filename)

        redirect to '/builds'
    end

    delete "/builds/:id" do
        build = getBuild(params)
        redirect_if_not_authorized(build)
        delete_previous_file_from_google(build.img_url)
        build.delete

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

        def upload_image_to_google
            filename = "#{SecureRandom.hex(10)}-build.png"

            storage = Google::Cloud::Storage.new(
                project_id: "youtubesearch-167217",
                credentials: "/Users/christiancain/Desktop/Flatiron/projects/clickyz/youtubesearch-167217-28e69b8eb833.json"
            )

            bucket  = storage.bucket "clickyz-builds"
            tempfile = Tempfile.new(['image', '.png'], binmode: true)
            tempfile.write(Base64.decode64(params[:image_data].remove("data:image/png;base64,")))
            bucket.create_file tempfile.path, filename

            filename
        end

        def delete_previous_file_from_google(filename)
            storage = Google::Cloud::Storage.new(
                project_id: "youtubesearch-167217",
                credentials: "/Users/christiancain/Desktop/Flatiron/projects/clickyz/youtubesearch-167217-28e69b8eb833.json"
            )

            bucket = storage.bucket "clickyz-builds"
            file = bucket.file filename

            file.delete
        end
    end
end