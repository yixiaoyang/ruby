class PersonalDetail < ActiveRecord::Base
  belongs_to  :profile, dependent: :destroy
  
  validates   :name, presence:true, length: { maximum: 64 }
  
  validates   :age, presence:true, inclusion: { in: AGE_MIN..AGE_MAX }, numericality: true
  
  validates   :sex, presence:true, inclusion: { in: 0...SEX_WORDS.size }, numericality: true
  
  # 创建时必须有profile_id且此id必须存在
  validates   :profile_id, presence:true, numericality: true, uniqueness:true
  
  # all email downcase
  before_save { self.email = email.downcase }
  validates   :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates   :mobile, presence:true, length: 6..30 
  
  def owner
    self.profile.user
  end
end
