class AddVotableToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :votable, polymorphic: true, index: true
  end
end
