class AddKarmaToCommentsAndPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :karma, :integer, default: 0
    add_column :comments, :karma, :integer, default: 0
  end
end
