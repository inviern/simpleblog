class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text,         null: false, limit: 10_000
      t.references :post,   index: true, foreign_key: true
      t.references :user,   index: true, foreign_key: true

      t.timestamps          null: false
    end
  end
end
