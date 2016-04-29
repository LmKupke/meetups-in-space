class MeetsCreateTable < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :description, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
