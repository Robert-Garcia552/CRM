class AddCaseIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :case_id, :integer
  end
end
