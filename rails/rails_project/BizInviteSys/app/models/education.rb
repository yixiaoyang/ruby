class Education < ActiveRecord::Base
  belongs_to  :profile
  
  def timeZone
    self.stime.strftime("%Y-%m") + "-" + self.etime.strftime("%Y-%m")
  end
end
