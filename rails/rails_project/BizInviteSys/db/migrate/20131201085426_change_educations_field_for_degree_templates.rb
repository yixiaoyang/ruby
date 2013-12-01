class ChangeEducationsFieldForDegreeTemplates < ActiveRecord::Migration
  def up
    change_column :educations, :degree, :integer
    add_column   :educations, :stime,  :datetime
    add_column   :educations, :etime,  :datetime
  end
  def down 
    change_column :educations, :degree, :string
  end
end
