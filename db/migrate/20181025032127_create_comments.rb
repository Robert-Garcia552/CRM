class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :author
      t.string :comment

      t.timestamps
    end

    remove_column :cases, :comments
  end
end
