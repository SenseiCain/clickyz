ActiveRecord::Schema.define(version: 20200527215138) do

  create_table "builds", force: :cascade do |t|
    t.string  "name"
    t.string  "case"
    t.integer "user_id"
    t.string  "primary_color"
    t.string  "alt_color"
    t.string  "img_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "username"
  end

end
