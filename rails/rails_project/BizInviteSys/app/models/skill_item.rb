class SkillItem < ActiveRecord::Base
  belongs_to  :profile
  belongs_to  :skill
  
  validates   :profile_id, presence:true, numericality: true
  
  # skill_id和profile_id两列唯一
  validates   :skill_id, presence:true, numericality: true, :uniqueness => { :scope => :profile_id }
  
  def owner
    self.profile.user
  end
end
