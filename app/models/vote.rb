class Vote < ApplicationRecord
  # don't let the user vote twice!
  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type] }

  belongs_to :votable, polymorphic: true
  belongs_to :user, inverse_of: :votes
  before_commit -> { update_karma(1) }, on: [:create]
  before_commit -> { update_karma(-1) }, on: [:destroy]


  def self.toggle_vote(user_id, votable_type, votable_id, value)
    vote = Vote.where(user_id: user_id, votable_type: votable_type, votable_id: votable_id).first
    vote.try(:destroy) || create(user_id: user_id, votable_type: votable_type, votable_id: votable_id, value: value)
  end

  def update_karma(add_or_subtract)
    net = value * add_or_subtract
    if self.votable_type === 'Post'
      self.votable.author.update(post_karma: self.votable.author.post_karma + net)
    elsif self.votable_type === 'Comment'
      self.votable.author.update(comment_karma: self.votable.author.comment_karma + net)
    end
    self.votable.update(karma: self.votable.karma + net)
  end
end