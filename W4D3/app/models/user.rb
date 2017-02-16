
class User < ActiveRecord::Base
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
 end

 def password=(password)
   @password = password
   self.password_digest = BCrypt::Password.create(password)
 end

 def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
 end

 def self.find_by_credentials(user_name, password)
   user = User.find_by(user_name: user_name)
   return user if  user && user.is_password?(password)
   nil
 end

end
