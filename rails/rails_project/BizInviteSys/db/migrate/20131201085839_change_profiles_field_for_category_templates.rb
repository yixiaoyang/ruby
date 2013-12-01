class ChangeProfilesFieldForCategoryTemplates < ActiveRecord::Migration
  def up
    change_column :profiles, :category, :integer
    change_column :profiles, :stat,     :integer
    
  end
  def down 
    change_column :profiles, :category, :string
    change_column :profiles, :stat,     :string
  end
end
