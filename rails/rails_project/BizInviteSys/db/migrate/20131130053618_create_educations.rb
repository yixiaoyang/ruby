class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :degree
      t.string :description
      t.integer :profile_id

      t.timestamps
    end
  end
end
