class Users < ActiveRecord::Migration
  def up
  	create_table "users", :force => true do |t|
      t.string   "email"
      t.string   "password_hash"
      t.string   "password_salt"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end
  end

  def down
  end
end
