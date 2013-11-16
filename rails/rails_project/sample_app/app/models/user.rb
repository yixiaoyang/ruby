class User < ActiveRecord::Base
  # dependent设置依赖关系，删除user时，其所属的micropost也会被destroy
  has_many :microposts , dependent: :destroy
  
  # 需要告知rails外键的变化
  has_many :follow_relationships, foreign_key: "follower_id", dependent: :destroy
  # 使用followed_users表示其关注的用户的集合即source指定的followed集合
  has_many :followed_users, through: :follow_relationships, source: :followed

  # 创建一个model‘类’reverse_relationships表示被关注者id是user.id的集合
  has_many :reverse_follow_relationships, foreign_key: "followed_id",
                                   class_name:  "FollowRelationship",
                                   dependent:   :destroy
  # 关注User的用户列表，对于:followers 属性而言，Rails 会把“followers”转成单数形式，
  # 自动寻找名为 follower_id 的外键
  has_many :followers, through: :reverse_follow_relationships, source: :follower
  
  # check name
  validates :name, presence:true, length: { maximum: 64 }
  
  # 把 Email 地址转换成全小写形式，确保唯一性
  before_save { self.email = email.downcase }
  
  # 真实的应用程序都会自动登入刚注册的用户（这样做的一个副作用就是创建了一个新的记忆权标），
  # 但是我们不想这么做，我们要用一种更好的方式，确保从一开始用户就有可用的记忆权标。为此，
  # 我们要使用回调函数生成权标
  before_create :create_remember_token

  
  # check email,Ruby 中的常量都是以大写字母开头的
#    正则表达式	含义
#    /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	完整的正则表达式
#    /	正则表达式开始
#    \A	匹配字符串的开头
#    [\w+\-.]+	一个或多个字母、加号、连字符、或点号
#    @	匹配 @ 符号
#    [a-z\d\-.]+	一个或多个小写字母、数字、连字符或点号
#    \.	匹配点号
#    [a-z]+	一个或多个小写字母
#    \z	匹配字符串结尾
#    /	结束正则表达式
#    i	不区分大小写c
#    
#    ref:http://rubular.com/
#    [abc]	A single character of: a, b, or c
#    [^abc]	Any single character except: a, b, or c
#    [a-z]	Any single character in the range a-z
#    [a-zA-Z]	Any single character in the range a-z or A-Z
#    ^	Start of line
#    $	End of line
#    \A	Start of string
#    \z	End of string
#    .	Any single character
#    \s	Any whitespace character
#    \S	Any non-whitespace character
#    \d	Any digit
#    \D	Any non-digit
#    \w	Any word character (letter, number, underscore)
#    \W	Any non-word character
#    \b	Any word boundary
#    (...)	Capture everything enclosed
#    (a|b)	a or b
#    a?	Zero or one of a
#    a*	Zero or more of a
#    a+	One or more of a
#    a{3}	Exactly 3 of a
#    a{3,}	3 or more of a
#    a{3,6}	Between 3 and 6 of a
#    options: i case insensitive m make dot match newlines x ignore
#      whitespace in regex o perform #{...} substitutions only once
  
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
    
  def feed
    # 问号可以确保 id 的值在传入底层的 SQL 查询语句之前做了适当的转义
    # 避免“SQL 注入”这种严重的安全隐患
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end
  
  # 一个user是否关注了other_user
  def following?(other_user)
    follow_relationships.find_by(followed_id: other_user.id)
  end

  # 加!一般表示可能有异常抛出
  def follow!(other_user)
    begin
    follow_relationships.create!(followed_id: other_user.id)
    rescue ActiveRecord::RecordNotUnique
    else  
    end
    
  end
  
  def unfollow!(other_user)
    relationship = follow_relationships.find_by(followed_id: other_user.id)
    relationship.destroy unless relationship.nil?
  end
 
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
