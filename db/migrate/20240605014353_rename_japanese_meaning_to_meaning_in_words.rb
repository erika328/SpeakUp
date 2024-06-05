class RenameJapaneseMeaningToMeaningInWords < ActiveRecord::Migration[7.1]
  def change
    rename_column :words, :japanese_meaning, :meaning
  end
end
