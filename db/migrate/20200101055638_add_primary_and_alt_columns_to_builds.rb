class AddPrimaryAndAltColumnsToBuilds < ActiveRecord::Migration
  def change
    remove_column :builds, :keycaps, :string
    add_column :builds, :primary_color, :string
    add_column :builds, :alt_color, :string
  end
end
