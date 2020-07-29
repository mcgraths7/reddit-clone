class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false
      t.string :slug, null: false
      t.timestamps
    end
    add_index :topics, :title, unique: true
    add_index :topics, :slug, unique: true
  end
end
