class Build < ActiveRecord::Base
    belongs_to :user

    def self.create_with_jpg(params, user)
        build = Build.create(name: params["keyboard_name"], case: params["case"], cable: params["cable"], primary_color: params["keycaps_primary"], alt_color: params["keycaps_alt"])
        build.user = user

        convert_svg_to_jpg(params, build)
    end

    private

    def self.convert_svg_to_jpg(params, build)
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
        File.delete(filepath)
    
        #assign file to build
        build.img_file = "keyboard_#{rand_num}.jpg"
        build.save
    end

    def delete_jpg(build)
        File.delete("public/images/keyboard_saves/#{build.img_file}")
    end
end