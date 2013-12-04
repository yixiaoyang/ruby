class SkillItem < ActiveRecord::Base
  belongs_to  :profile
  has_many    :skiils
  
  def skill_belongs_to
    Skill.find(self.skill_id)
  end
end
