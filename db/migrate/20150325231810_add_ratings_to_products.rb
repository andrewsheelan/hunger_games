class AddRatingsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ratings, :integer
  end
end
