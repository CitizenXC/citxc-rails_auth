class AddConfirmationAndPasswordColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmation_token, :string, null: false
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :confirmed_at, :datetime
    add_column :users, :password_digest, :string, null: false

    add_index :users, :confirmation_token, unique: true
  end
end
