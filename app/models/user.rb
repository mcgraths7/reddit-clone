 class User < ApplicationRecord
  # Need this to be able to verify password_digest, since we don't save password in db
  attr_reader :password

  # Model validations
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password cannot be blank' }
  validates :password, length: { minimum: 8, allow_nil: true }

  # Ensures a session token is generated each time a new user object is initialized
  after_initialize :ensure_session_token

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    return if user.nil?
    user.is_password(password) ? user : nil
  end

  # Methods to create and verify password_digest from password
  def password=(pw)
    @password = pw
    password_digest = BCrypt::Password.create(pw)
  end

  def is_password(pw)
    BCrypt::Password.new(pw).is_password(password_digest)
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