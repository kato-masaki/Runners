class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :user_id
      t.string :image_id
      t.text :caption
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
