class AddColumnToCases < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :cases,, :string
    add_column :cases, :estimated_completion_date, :string
  end
end
