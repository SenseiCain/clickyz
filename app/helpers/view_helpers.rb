class ViewHelpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.show_editor_links(session)
        links = ["information"]

        if is_logged_in?(session)
            links.push("orders", "logout")
        else
            links.push("login")
        end

        links.map do |l|
            "<li><a href='/#{l}'>#{l.capitalize()}</a></li>"
        end.join(" ")
    end

    def self.show_info_links(session)
        links = ["editor"]

        if is_logged_in?(session)
            links.push("orders", "logout")
        else
            links.push("login")
        end

        links.map do |l|
            link = '/' + l
            (l == "editor") ? link = '/' : link = l
            "<li><a href='#{link}'>#{l.capitalize()}</a></li>"
        end.join(" ")
    end

    def self.show_orders_links(session)
        links = ["editor"]

        if is_logged_in?(session)
            links.push("information", "logout")
        else
            links.push("login")
        end

        links.map do |l|
            link = '/' + l
            (l == "editor") ? link = '/' : link = l
            "<li><a href='#{link}'>#{l.capitalize()}</a></li>"
        end.join(" ")
    end
end