class CreatePersonalDetails < ActiveRecord::Migration
  def change
    create_table :personal_details do |t|
      t.string :name
      t.integer :age
      t.string :sex
      t.string :email
      t.string :mobile
      t.integer :profile_id

      t.timestamps
    end
  end
end
