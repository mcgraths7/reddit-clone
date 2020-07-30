class ChangeCommentsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_comment_id, :integer
    rename_column :comments, :parent_post_id, :post_id
    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end
