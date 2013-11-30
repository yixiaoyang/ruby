class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :category
      t.integer :score
      t.string :description
      t.integer :profile_id

      t.timestamps
    end
  end
end
