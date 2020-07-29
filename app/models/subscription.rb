class Subscription < ApplicationRecord
  validate :user_cannot_subscribe_to_the_same_topic_twice
  
  belongs_to :user
  belongs_to :topic
  
  def user_cannot_subscribe_to_the_same_topic_twice
    unless user.subscribed_topics.where(id: self.topic.id).empty?
      errors[:user] << 'cannot subscribe to the same topic twice'
    end
  end
end