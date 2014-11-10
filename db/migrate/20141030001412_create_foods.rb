class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
