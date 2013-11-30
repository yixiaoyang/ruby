class SkillItem < ActiveRecord::Base
  belongs_to  :profile
  has_many    :skiils
end
