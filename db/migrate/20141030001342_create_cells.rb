class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :propensity_to_move
      t.integer :propensity_to_reproduce
      t.integer :satiety
      t.integer :x
      t.integer :y
      t.boolean :has_mated

      t.timestamps
    end
  end
end
