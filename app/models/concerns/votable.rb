module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes,
             as: :votable,
             class_name: :Vote,
             dependent: :destroy
  end

  def update_karma
    karma = 0
    karma = votes.reduce(0) { |acc, vote| acc += vote.value }
    self.update(karma: karma)
  end
end