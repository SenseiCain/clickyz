class RemoveCableFromBuilds < ActiveRecord::Migration
  def change
    remove_column :builds, :cable
  end
end
