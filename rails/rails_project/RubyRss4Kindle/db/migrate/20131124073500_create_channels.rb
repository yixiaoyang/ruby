class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :url
      t.string :title
      t.string :description
      
      t.datetime :fetch_at
      t.timestamps
    end
  end
end
