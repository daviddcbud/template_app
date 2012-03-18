class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique:true
    add_index :users, :session_token
  end
end
