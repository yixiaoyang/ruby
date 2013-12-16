class Profile < ActiveRecord::Base
  # foreign_key is user_id
  belongs_to :user
  
  # 一份profile内容的组成
  has_one   :personal_detail ,dependent: :destroy
  has_many  :educations,dependent: :destroy

  has_many  :skill_items,dependent: :destroy
  has_many  :skills, through: :skill_items
  
  has_many  :comments, dependent: :destroy
  
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
  
  def skill_item_with_skillId(skill_id)
    skill_item = SkillItem.find_by(:skill_id => skill_id, :profile_id=> self.id)
    p skill_item
    skill_item
  end
  
  def update_score
    self.score = self.skills.sum(:score);
    self.save
    self.score
  end
end
