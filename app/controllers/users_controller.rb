class UsersController < ApplicationController
    get "/login" do
        erb :login
    end
    
    post "/register" do
    
        if params["username"] != '' && params["email"] != '' && params["password"] != ''
            @user = User.new(username: params["username"], email: params["email"], password: params["password"])
        
            if @user.save
                session[:user_id] = @user.id
                redirect to "/"
            else
                redirect to "/login"
            end
        else
                redirect to "/login"
        end
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

end