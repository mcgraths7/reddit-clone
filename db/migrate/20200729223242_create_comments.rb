class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id
      t.integer :parent_post_id
    end
  end
end
