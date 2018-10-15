class EditColumnForCases < ActiveRecord::Migration[5.2]
  def change
    rename_column :cases, :type, :category
  end
end
