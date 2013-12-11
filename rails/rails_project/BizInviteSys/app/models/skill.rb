class Skill < ActiveRecord::Base
  # 一种技能有多个满足条件的简历（profile）和条目
  has_many :skill_items,dependent: :destroy
  has_many :profiles,through: :skill_items

  validates   :category,    presence:true, inclusion: { in: 0...SKILL_CATEGORY_WORDS.size }, numericality: true
  validates   :score,       presence:true, numericality: true
  validates   :description, presence:true, length: { maximum: DESCRIPTION_LEN_MAX }
end
