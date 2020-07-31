class AddVotableToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :votable_type, :string
    add_column :votes, :votable_id, :integer
    add_index :votes, :votable_type
    add_index :votes, :votable_id
  end
end
