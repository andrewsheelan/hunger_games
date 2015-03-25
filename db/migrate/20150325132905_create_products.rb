class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :company, index: true
      t.float :price
      t.text :description
      t.integer :quantity
      t.attachment :image

      t.timestamps null: false
    end
    add_foreign_key :products, :companies
  end
end
