class StimeBeforeEtimeValidator < ActiveModel::Validator
  def validate(record)
    if record.stime.nil? or record.etime.nil? or record.stime >= record.etime
      record.errors[:base] << "Start date should before end date"
    end
  end
end

class Education < ActiveRecord::Base
  belongs_to  :profile
  
  validates  :stime, presence:true
  validates  :etime, presence:true
  # 创建时必须有profile_id且此id必须存在
  validates   :profile_id, presence:true, numericality: true
  
  validates :description, presence:true, length: { maximum: 1000 }
  
  # 自定义验证器验证时间段
  validates_with StimeBeforeEtimeValidator

  def timeZone
    self.stime.strftime("%Y-%m") + " ~ " + self.etime.strftime("%Y-%m")
  end
  
  def owner
    self.profile.user
  end
  
end

