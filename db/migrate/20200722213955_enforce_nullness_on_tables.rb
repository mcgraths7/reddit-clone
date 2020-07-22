class EnforceNullnessOnTables < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :author_id, :integer, null: false
    change_column :topics, :title, :string, null: false
    change_column :topics, :description, :text, null: false
    change_column :topics, :moderator_id, :integer, null: false
    change_column :users, :username, :string, null: false
    change_column :users, :session_token, :string, null: false
  end
end
