class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :session_token
      t.string :password_reset_token
      t.integer :failed_password_attempts
      t.timestamps
    end
  end
end
