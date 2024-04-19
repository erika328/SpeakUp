class AddColumnUsernameToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string, null: false
  end
end
