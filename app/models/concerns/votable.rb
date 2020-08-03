module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes,
      as: :votable,
      class_name: :Vote,
      dependent: :destroy

    after_save do
      update_hotness
    end
  end

  private
  def multipliers
    multipliers = {}
    (0..24).reduce(2.0) do |multiplier, hour|
      multipliers[hour] = multiplier
      multiplier -= 0.041
    end
    multipliers
  end

  def time_ago_in_hours
    created_at_in_time = self.created_at.to_time
    now = Time.now
    time_ago = now - created_at_in_time
    time_ago_in_hours = time_ago / 3600
    time_ago_in_hours.round
  end

  def hotness_score
    if time_ago_in_hours <= 24
      karma * multipliers[time_ago_in_hours]
    else
      karma
    end
  end

  def update_hotness
    hotness = hotness_score
  end
end