class Micropost < ActiveRecord::Base
  belongs_to :user

  # 设定作用域，DESC为倒序， order('created_at DESC')为匿名函数，以 -> 开头，后面跟着
  # 一个代码块，调用 call 方法时才执行块中的代码
  #
  # 从 Rails 4.0 开始，所有的作用域都需要通过匿名函数的方式定义，函数的返回值为所需的条件
  # 这么做主要的好处是，作用域的条件不用立即计算，只在需要时才执行（所以叫做“惰性计算”）
  default_scope -> { order('created_at DESC') }
  
  # 管理员是有权限删除用户的。那么，在删除用户的同时，就有必要把该用户发布的微博也删除
  
  
  validates :content, presence: true, length: { maximum: 300 }
  validates :user_id, presence: true
  
  def self.from_users_followed_by(user)
    # 获取关注列表，注意命名规则
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end
end
