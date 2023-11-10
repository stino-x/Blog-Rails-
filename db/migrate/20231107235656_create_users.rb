class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :bio, null: false
      t.integer :posts_counter, default: 0
      t.string :photo
      t.timestamps
    end
  end
end