class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.boolean :open
      t.integer :dishes

      t.timestamps
    end
  end
end
