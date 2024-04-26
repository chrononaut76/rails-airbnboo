class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.text :description
      t.decimal :price
      t.string :image_url
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
