class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :score
      t.string :vluation
      t.integer :profile_id
      t.integer :user_id

      t.timestamps
    end
  end
end
