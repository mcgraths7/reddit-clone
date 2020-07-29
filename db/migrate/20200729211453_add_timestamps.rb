class AddTimestamps < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
    add_column :subscriptions, :created_at, :datetime
    
  end
end
