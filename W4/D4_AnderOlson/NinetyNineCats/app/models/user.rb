class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize do |user|
    user.session_token ||= create_session_token
  end

  has_many :cats
  has_many :logins

  def create_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user_instance = User.find_by(user_name: user_name)
    if user_instance.is_password?(password)
      return user_instance
    end

    nil
  end
end
