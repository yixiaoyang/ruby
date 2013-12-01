class ChangePersonalDetailsFieldForSexTemplates < ActiveRecord::Migration
  def up
    change_column :personal_details, :sex, :integer
  end
  def down 
    change_column :personal_details, :sex, :string
  end
end
