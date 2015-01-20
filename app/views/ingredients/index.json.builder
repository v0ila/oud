json.array!(@ingredients) do |ingredient|
  ingredient.extract! ingredient, :id, :latitude, :longitude, :address, :description, :title
  ingredient.url ingredient_url(ingredient, format: :json)
end