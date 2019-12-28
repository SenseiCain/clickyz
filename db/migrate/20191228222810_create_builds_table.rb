class CreateBuildsTable < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :name
      t.string :case
      t.string :keycaps
      t.string :cable
      t.integer :user_id
    end
  end
end
