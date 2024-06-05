class AddExampleToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :example, :string
  end
end
