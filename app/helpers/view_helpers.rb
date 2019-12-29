class ViewHelpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.show_links(session, path)
        links = ["editor", "information"]

        if is_logged_in?(session)
            links.push("logged_in")
        else
            links.push("login")
        end

        links.map do |l|
            link = '/' + l
            (l == "editor") ? link = '/' : link = '/' + l

            if l == "logged_in"
                "<li class='nav-item dropdown'>
                    <a class='nav-link dropdown-toggle' href='#' id='navbarDropdown' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
                    #{current_user(session).username}
                    </a>
                    <div class='dropdown-menu' aria-labelledby='navbarDropdown'>
                        <a class='dropdown-item' href='/builds'>Builds</a>
                        <a class='dropdown-item' href='/logout'>Logout</a>
                    </div>
                </li>"
            else
                "<li class='nav-item'>
                    <a class='nav-link #{(path == link) ? 'active' : ''}' href=#{link}>#{l.capitalize()}</a>
                </li>"
            end
        end.join(" ")
    end
end