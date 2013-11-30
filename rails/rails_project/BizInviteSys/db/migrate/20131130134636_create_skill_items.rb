class CreateSkillItems < ActiveRecord::Migration
  def change
    create_table :skill_items do |t|
      t.integer :skill_id
      t.integer :profile_id

      t.timestamps
    end
  end
end
