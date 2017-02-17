# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password, :confirmation_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true
  validate :emaillike_email_address
  validate :matching_password_entries

  after_initialize :ensure_session_token

  def emaillike_email_address
    unless /\./.match(self.email) && /@/.match(self.email)
      errors[:email] << "supplied is invalid"
    end
  end

  def matching_password_entries
    unless self.confirmation_password == self.password
      errors[:passwords] << "don't match"
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def has_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def confirmation_password=(confirmation_password)
    @confirmation_password = confirmation_password
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.has_password?(password) ? user : nil
  end

end
