class AddColumnToClientAndCase < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :agent_id, :integer
    add_column :cases, :client_id, :integer
  end
end
