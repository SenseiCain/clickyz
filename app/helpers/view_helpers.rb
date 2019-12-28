class ViewHelpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.show_links(session)
        links = ["editor", "information"]

        if is_logged_in?(session)
            links.push("orders", "logout")
        else
            links.push("login")
        end

        links.map do |l|
            link = '/' + l
            (l == "editor") ? link = '/' : link = l
            
            "<li class='nav-item'>
                <a class='nav-link' href=#{link}>#{l.capitalize()}</a>
            </li>"
        end.join(" ")
    end
end