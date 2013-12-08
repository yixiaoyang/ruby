class User < ActiveRecord::Base
  # 一个用户有多个profile，每个profile在用户被删除后都自动被删除
  has_one :profile, dependent: :destroy
  
  # check name
  validates :name, presence:true, length: { maximum: 64 }
  
  # all email downcase
  before_save { self.email = email.downcase }
  
  # for session token
  before_create :create_remember_token

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
             uniqueness: { case_sensitive: false }
  #validates :email, presence:true
  
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
