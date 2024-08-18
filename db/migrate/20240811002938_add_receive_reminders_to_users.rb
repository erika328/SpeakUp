class AddReceiveRemindersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :receive_reminders, :boolean, default: true
  end
end
