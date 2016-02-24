class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :commenter, index: true
      t.references :recipient, index: true

      t.timestamps null: false
    end

    add_foreign_key :comments, :users, column: :commenter_id
    add_foreign_key :comments, :users, column: :recipient_id
  end
end
