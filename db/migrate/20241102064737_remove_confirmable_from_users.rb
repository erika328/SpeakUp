class RemoveConfirmableFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :confirmation_token, :string
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_sent_at, :datetime
    remove_column :users, :unconfirmed_email, :string # Only if using reconfirmable
  end
end
