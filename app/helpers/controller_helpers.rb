module ControllerHelpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def login(email)

    end

    def register(email, password, name)

    end
    
    def logout
        session.clear
    end
end