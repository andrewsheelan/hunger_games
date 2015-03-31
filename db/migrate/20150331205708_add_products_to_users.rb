class AddProductsToUsers < ActiveRecord::Migration
  def change
   create_table :products_users do |t|
     t.belongs_to :product, index: true, null: false
     t.belongs_to :user, index: true, null: false
   end
   add_index :products_users, [:product_id, :user_id], unique: true, name: "products_user_index"
  end
end
