class UpdateUsernameForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    add_column :users, :username, :string
  end
end
