class AddHotnessScoreToVotable < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :hotness, :float
    add_column :comments, :hotness, :float
  end
end
