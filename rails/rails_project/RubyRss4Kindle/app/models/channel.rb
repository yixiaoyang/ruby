class Channel < ActiveRecord::Base
  belongs_to :user
  
  validates :url, presence:true, length: { maximum: 1024 }, uniqueness: { case_sensitive: false }
  validates :user_id, presence:true
  validates :title, presence:true, length: { maximum: 64 }
  validates :description, length: { maximum: 1024 }
  
  
  before_save { self.url = url.downcase }
  
  
  
end
