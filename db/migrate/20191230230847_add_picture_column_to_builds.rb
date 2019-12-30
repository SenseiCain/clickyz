class AddPictureColumnToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :img_file, :string
  end
end
