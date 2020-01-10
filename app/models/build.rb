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
        delete_jpg
        self.delete
    end
    

    private

    def delete_jpg
        File.delete("public/images/keyboard_saves/#{self.img_file}")
    end

    def create_jpg(params)
        #generates svg as placeholder
        rand_num = rand(1000)
        filepath = "lib/temp_svgs/temp_svg_#{rand_num}.svg"
        temp_file = File.open(filepath, "w")  do |f| 
            text_2 = params[:svg] + '</svg>'
            text_2.slice! "<svg>"
    
            f.write(File.open('lib/svgs/metadata.txt', 'r').read)
            f.write(text_2)
        end

        #converts svg to jpg & save
        image = MiniMagick::Image.open(filepath)
        image.format "jpg"
        image.write "public/images/keyboard_saves/keyboard_#{rand_num}.jpg"
    
        #delete placeholder svg
        delete_jpg
    
        #assign file to build
        self.img_file = "keyboard_#{rand_num}.jpg"
    end
end