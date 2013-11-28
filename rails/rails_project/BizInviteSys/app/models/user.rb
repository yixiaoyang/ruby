class User < ActiveRecord::Base
  # check name
  validates :name, presence:true, length: { maximum: 64 }
  
  # all email downcase
  before_save { self.email = email.downcase }
  
  # for session token
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
             uniqueness: { case_sensitive: false }
  validates :email, presence:true
  
  # password check
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end 
  
  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
