class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :current_weight
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
