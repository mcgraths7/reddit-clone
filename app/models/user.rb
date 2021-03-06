 class User < ApplicationRecord
  extend FriendlyId

  friendly_id :username, use: :slugged
  # Need this to be able to verify password_digest, since we don't save password in db
  attr_reader :password

  # Model validations
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password cannot be blank' }
  validates :password, length: { minimum: 8, allow_nil: true }

  # Ensures a session token is generated each time a new user object is initialized
  after_initialize :ensure_session_token

  # Associations
  has_many :topics,
           foreign_key: :moderator_id,
           primary_key: :id,
           inverse_of: :moderator
  has_many :subscriptions
  has_many :subscribed_topics,
           class_name: :Topic,
           through: :subscriptions,
           source: :topic
  has_many :subscribed_posts,
           class_name: :Post,
           through: :subscribed_topics,
           source: :posts
  has_many :posts, inverse_of: :author,
           foreign_key: :author_id,
           primary_key: :id,
           dependent: :destroy
  has_many :comments,
           inverse_of: :author,
           foreign_key: :author_id,
           primary_key: :id,
           dependent: :destroy
  has_many :votes,
           inverse_of: :user,
           dependent: :destroy

  def update_karma
    post_karma = posts.reduce(0) { |acc, post| acc += post.karma }
    comment_karma = comments.reduce(0) { |acc, comment| acc += comment.karma }
    self.update(post_karma: post_karma, comment_karma: comment_karma)
  end

  def subscribe_to(topic_id)
    topic = Topic.find_by(id: topic_id)
    if topic
      s = Subscription.new(user_id: self.id, topic_id: topic.id)
      unless s.save
        errors[:topic] << 'could not subscribe'
      end
    else
      errors[:topic] << 'not found'
    end
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return if user.nil?
    user.is_password?(password) ? user : nil
  end

  # Methods to create and verify password_digest from password
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  # Methods to manage user session
   def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
 end