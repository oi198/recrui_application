class CreateEs < ActiveRecord::Migration[6.1]
  def change
    create_table :es do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :company_id
      t.timestamps
    end
  end
end
