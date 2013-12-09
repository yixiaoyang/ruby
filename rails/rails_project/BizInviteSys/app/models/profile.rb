class Profile < ActiveRecord::Base
  # foreign_key is user_id
  belongs_to :user
  
  # 一份profile内容的组成
  has_many  :skill_items
  has_one   :personal_detail
  has_many  :educations

end
