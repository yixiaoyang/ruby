class AddIndexToChannelsUrl < ActiveRecord::Migration
  def change
    add_index :channels, :url,  unique: true
  end
end
