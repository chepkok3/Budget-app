class UpdateUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :email, default: '', null: false
      t.string :encrypted_password, default: '', null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.string :role, default: 'user'
    end

    add_index :users, :confirmation_token, unique: true, name: 'index_users_on_confirmation_token'
    add_index :users, :email, unique: true, name: 'index_users_on_email'
    add_index :users, :reset_password_token, unique: true, name: 'index_users_on_reset_password_token'
  end
end
