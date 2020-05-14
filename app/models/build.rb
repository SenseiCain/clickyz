class Build < ActiveRecord::Base
    belongs_to :user

    def self.create_with_jpg(params, user)
        build = Build.create(name: params["keyboard_name"], case: params["case"], cable: params["cable"], primary_color: params["keycaps_primary"], alt_color: params["keycaps_alt"])
        build.user = user
        build.create_jpg(params)

        build.save
    end

    def update_with_jpg(params)
        self.name = params[:keyboard_name]
        self.primary_color = params[:keycaps_primary]
        self.alt_color = params[:keycaps_alt]
        self.case = params[:case]
        self.cable = params[:cable]
        create_jpg(params)

        self.save
    end

    def delete_with_jpg
        File.delete("public/images/keyboard_saves/#{img_file}")
        self.delete
    end

    def create_jpg(params)
        #Generate placeholder file for SVG that is to be converted (MiniMagick req)
        rand_num = rand(1000)
        filepath = "public/images/keyboard_saves/keyboard_#{rand_num}.png"

        #Reformat SVG with original metadata
        File.open(filepath, "wb")  do |f| 
            f.write(Base64.decode64(params[:image]['data:image/png;base64,'.length .. -1]))
        end
    
        #Assign file to build
        self.img_file = "keyboard_#{rand_num}.png"
    end
end