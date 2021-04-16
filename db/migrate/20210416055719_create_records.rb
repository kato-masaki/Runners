class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :user_id
      t.datetime :start_time
      t.float :distance
      t.integer :hour
      t.integer :minute
      t.integer :second
      t.integer :pace_minute
      t.integer :pace_second

      t.timestamps
    end
  end
end
