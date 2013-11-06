class CreateFollowRelationships < ActiveRecord::Migration
  def change
    create_table :follow_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    
    add_index :follow_relationships,:follower_id
    add_index :follow_relationships, :followed_id
    # 确保一个用户无法多次关注另一个用户
    add_index :follow_relationships, [:follower_id, :followed_id], unique:true
  end
end
