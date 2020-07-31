class AddKarmaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :comment_karma, :integer, default: 0
    add_column :users, :post_karma, :integer, default: 0
  end
end
