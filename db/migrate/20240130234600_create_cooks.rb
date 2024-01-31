class CreateCooks < ActiveRecord::Migration[7.1]
  def change
    create_table :cooks do |t|
      t.string :name
      t.boolean :serv_safe_certified
      t.integer :dishes_known
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
