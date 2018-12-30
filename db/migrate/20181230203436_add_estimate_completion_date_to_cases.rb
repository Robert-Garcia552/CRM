class AddEstimateCompletionDateToCases < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :estimated_completion_date, :string
  end
end
