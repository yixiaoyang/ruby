class SkillItem < ActiveRecord::Base
  belongs_to  :profile, dependent: :destroy
  belongs_to  :skill,   dependent: :destroy
  
  validates   :profile_id, presence:true, numericality: true
  validates   :skill_id, presence:true, numericality: true
end
