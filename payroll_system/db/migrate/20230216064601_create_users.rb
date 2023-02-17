# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender_type
      t.string :email_id, unique: true
      t.integer :phone_no
      t.string :designation_type
      t.string :city_name
      t.date :join_date
      t.integer :tot_paid_leaves

      t.timestamps
    end
  end
end
