class AddFileUrlToBuilds < ActiveRecord::Migration
  def change
    remove_column :builds, :img_file, :string
    add_column :builds, :img_url, :string
  end
end
