class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.integer :day
      t.integer :start_hour
      t.integer :start_minute
      t.integer :end_hour
      t.integer :end_minute
      t.timestamps
    end
  end
end
