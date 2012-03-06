class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :subcategory_id
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :location
      t.integer :vote_interval

      t.timestamps
    end
  end
end
