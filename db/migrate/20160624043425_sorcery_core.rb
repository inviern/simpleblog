class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,             null: false, limit: 32
      t.string :email,            null: false, limit: 32
      t.string :crypted_password, null: false
      t.string :salt,             null: false

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :email, unique: true
  end
end