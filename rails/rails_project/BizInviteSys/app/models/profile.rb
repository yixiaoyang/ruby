class Profile < ActiveRecord::Base
  belongs_to :user
  
  # 一份profile内容的组成
  has_many  :skiil_items
  has_many  :personal_details
  has_many  :educations
  
  
end
