class Build < ActiveRecord::Base
    belongs_to :user

    def self.create_with_img(params, user, filename)
        build = Build.new
        build.name = params["keyboard_name"]
        build.case = params["case"]
        build.primary_color = params["keycaps_primary"]
        build.alt_color = params["keycaps_alt"]
        build.img_url = filename
        build.user = user

        build.save
    end

    def update_with_img(params, filename)
        self.name = params[:keyboard_name]
        self.primary_color = params[:keycaps_primary]
        self.alt_color = params[:keycaps_alt]
        self.case = params[:case]
        self.img_url = filename

        self.save
    end
end