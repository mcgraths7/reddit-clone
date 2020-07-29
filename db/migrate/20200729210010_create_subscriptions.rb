class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :topic_id, null: false
      t.integer :user_id, null: false
    end
    add_index :subscriptions, :user_id
  end
end
