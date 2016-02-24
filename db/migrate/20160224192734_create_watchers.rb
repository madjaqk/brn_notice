class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.references :watcher, index: true
      t.references :watched, index: true

      t.timestamps null: false
    end

    add_foreign_key :watchings, :users, column: :watcher_id
    add_foreign_key :watchings, :users, column: :watched_id
    add_index :watchings, [:watcher_id, :watched_id], unique: true
  end
end
