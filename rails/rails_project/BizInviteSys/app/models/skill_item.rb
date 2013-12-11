class SkillItem < ActiveRecord::Base
  belongs_to  :profile
  belongs_to  :skill
  
  validates   :profile_id, presence:true, numericality: true
  validates   :skill_id, presence:true, numericality: true
end
