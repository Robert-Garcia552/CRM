class CorrectTables < ActiveRecord::Migration[5.2]
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

    create_table :clients do |t|
      t.belongs_to :agent, index: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :insurance
      
      t.timestamps
    end

    create_table :cases do |t|
      t.belongs_to :client, index: true
      t.string :category, null: false
      t.string :description
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end

    create_table :comments do |t|
      t.string :author
      t.string :comment

      t.timestamps
    end
    
  end
end
