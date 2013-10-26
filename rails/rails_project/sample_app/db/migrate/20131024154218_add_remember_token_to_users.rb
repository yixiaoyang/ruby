class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    # 修改生成的迁移文件。注意，因为我们要使用记忆权标取回用户，所以我们为 
    # remember_token 列加了索引
    add_column :users, :remember_token, :string
    add_index :users, :remember_token
  end
end
