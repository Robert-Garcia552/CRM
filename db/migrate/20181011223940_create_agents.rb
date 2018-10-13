class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :birthdate, null: false
      t.string :password_digest
      t.string :email, null: false
      t.string :phone_number, null: false
      t.boolean :admin, default: false
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.timestamps
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
