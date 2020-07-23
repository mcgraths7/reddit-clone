class EnforceNullOnTopicId < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :topic_id, :integer, null: false
  end
end
