class AddVotableToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :votable, polymorphic: true, index: true
  end
end
