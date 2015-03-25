json.array!(@products) do |product|
  json.extract! product, :id, :name, :company_id, :price, :description, :quantity, :image
  json.url product_url(product, format: :json)
end
