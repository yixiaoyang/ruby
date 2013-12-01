class ChangeSkillFieldForCategoryTemplates < ActiveRecord::Migration
  def up
    change_column :skills, :category, :integer
  end
  def down 
    change_column :skills, :category, :string
  end
end
