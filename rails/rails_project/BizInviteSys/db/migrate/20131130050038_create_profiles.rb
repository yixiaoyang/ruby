class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :category
      t.string :stat
      t.integer :score

      t.timestamps
    end
  end
end
