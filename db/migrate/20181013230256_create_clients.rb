class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :insurance
      
      t.timestamps
    end
  end
end
