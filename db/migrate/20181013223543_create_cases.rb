class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      t.string :type
      t.string :description
      t.string :comments

      t.timestamps
    end
  end
end
