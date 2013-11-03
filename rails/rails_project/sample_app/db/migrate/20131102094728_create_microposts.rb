class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # 块中最后一行 t.timestamps 是个特殊的方法，它会自动创建两个列，created_at 和
    # updated_at，这两个列分别记录创建用户的时间戳和更新用户数据的时间戳
    add_index :microposts, [:user_id, :created_at]
  end
end
