class ViewHelpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    #Layout.erb
    def self.show_links(session, path)
        links = ["editor"]

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

    #Index.erb
    def self.generate_options(selection_type, session)
        options = {
            "keycaps_primary" => ["AntiqueWhite", "Snow", "DimGrey", "Aquamarine", "DarkOrange", "Navy", "Turquoise", "HotPink", "Orchid", "GoldenRod", "Crimson", "Lime", "PowderBlue"],
            "keycaps_alt" => ["AntiqueWhite", "Snow", "DimGrey", "Aquamarine", "DarkOrange", "Navy", "Turquoise", "HotPink", "Orchid", "GoldenRod", "Crimson", "Lime", "PowderBlue"],
            "case" => ["SlateGrey", "Silver", "GoldenRod", "BurlyWood", "DarkOliveGreen", "LightSeaGreen", "LimeGreen", "Salmon", "Chocolate", "BlueViolet", "Navy"],
            "cable" => ["Crimson", "Orange", "Navy", "Orchid", "HotPink", "Lime", "Cyan", "Gold"]
        }

        options_rand = rand(0...options[selection_type].length)
        html_options = []

        if session[:keyboard_data]
            options[selection_type].each_with_index do |o, i|
                html_options.push("<option #{session[:keyboard_data][selection_type] == o ? 'selected' : ''} value='#{o}'>#{o}</option>")
            end
        else
            options[selection_type].each_with_index do |o, i|
                html_options.push("<option #{options[selection_type].index(o) == options_rand ? 'selected' : ''} value='#{o}'>#{o}</option>")
            end
        end

        html_options.join('')
    end

    #Edit.erb
    def self.generate_options_for_edit(build_atr, selection_type)
        options = {
            "keycaps_primary" => ["AntiqueWhite", "Snow", "DimGrey", "Aquamarine", "DarkOrange", "Navy", "Turquoise", "HotPink", "Orchid", "GoldenRod", "Crimson", "Lime", "PowderBlue"],
            "keycaps_alt" => ["AntiqueWhite", "Snow", "DimGrey", "Aquamarine", "DarkOrange", "Navy", "Turquoise", "HotPink", "Orchid", "GoldenRod", "Crimson", "Lime", "PowderBlue"],
            "case" => ["SlateGrey", "Silver", "GoldenRod", "BurlyWood", "DarkOliveGreen", "LightSeaGreen", "LimeGreen", "Salmon", "Chocolate", "BlueViolet", "Navy"],
            "cable" => ["Crimson", "Orange", "Navy", "Orchid", "HotPink", "Lime", "Cyan", "Gold"]
        }

        html_options = []

        options[selection_type].each do |o|
            html_options.push("<option #{build_atr == o ? 'selected' : ''} value='#{o}'>#{o}</option>")
        end

        html_options.join('')

    end
end