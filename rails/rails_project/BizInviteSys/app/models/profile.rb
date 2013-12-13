class Profile < ActiveRecord::Base
  # foreign_key is user_id
  belongs_to :user
  
  # 一份profile内容的组成
  has_one   :personal_detail ,dependent: :destroy
  has_many  :educations,dependent: :destroy

  has_many  :skill_items,dependent: :destroy
  has_many  :skills, through: :skill_items
  
  # 返回所有已有技能项的id数组
  def skill_ids(category=0)
    ids = []
    self.skills.each{ |skill| 
      ids.push(skill.id) unless (skill.category != category)
    }
    p ids
    ids
  end
  
  # 返回所有已有技能项的id数组
  def skill_ids_all
    ids = []
    self.skills.each{ |skill|  ids.push(skill.id) }
    ids
  end
end
