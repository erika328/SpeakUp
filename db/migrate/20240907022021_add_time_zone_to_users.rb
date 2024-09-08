class AddTimeZoneToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :time_zone, :string, default: "Asia/Tokyo"
  end
end
