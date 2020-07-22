class CreateTopic < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title, index: true, unique: true
      t.text :description
      t.integer :moderator_id, foreign_key: true
    end
  end
end
