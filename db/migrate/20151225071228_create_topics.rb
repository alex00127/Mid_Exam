class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
