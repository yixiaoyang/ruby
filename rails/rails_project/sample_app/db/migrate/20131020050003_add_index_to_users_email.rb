class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    #为 email 列建立索引同时也解决了find_by_email 的效率问题,也便于检验唯一性
   add_index :users, :email, unique: true
  end
end
