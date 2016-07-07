class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title,      null: false, limit: 255
      t.text :text,         limit: 10_000
      t.references :user,   index: true, foreign_key: true

      t.timestamps          null: false
    end
  end
end
