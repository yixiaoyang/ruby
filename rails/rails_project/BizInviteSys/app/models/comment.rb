class Comment < ActiveRecord::Base
  belongs_to :profile
  belongs_to :user
  
  validates :score, presence:true, numericality: { only_integer: true, greater_than:0, less_than_or_equal_to:100 }
  validates :vluation, presence:true, length: { maximum: VLUATION_LEN_MAX }
  validates :profile_id, presence:true, numericality: { only_integer: true }
  validates :user_id, presence:true, numericality: { only_integer: true }

  # 撰写人
  def owner
    self.user
  end
end