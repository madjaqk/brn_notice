class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.text :about
      t.integer :start_weight
      t.integer :goal_weight
      t.string :profile_picture
      t.string :provider
      t.string :uid
      t.decimal :zip_code, precision:5, scale:0
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
