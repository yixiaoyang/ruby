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
  
  validates :description, presence:true, length: { maximum: 1000 }
  
  # 自定义验证器
  validates_with StimeBeforeEtimeValidator

  def timeZone
    self.stime.strftime("%Y-%m") + "-" + self.etime.strftime("%Y-%m")
  end
end

