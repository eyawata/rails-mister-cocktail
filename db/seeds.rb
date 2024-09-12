require 'open-uri'
require 'nokogiri'

puts "Deleting Doses"
Dose.destroy_all
puts "Deleting Ingredients"
Ingredient.destroy_all
puts "Deleting Cocktails"
Cocktail.destroy_all

INGREDIENTS_URL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

ingredients_data = URI.open(INGREDIENTS_URL).read
parsed_json = JSON.parse(ingredients_data)

puts "Creating drinks..."

parsed_json["drinks"].each do |drink|
  Ingredient.create!(
    name: drink["strIngredient1"]
  )
end

puts "Created #{Ingredient.count} ingredients!"
puts "Creating cocktails..."

cocktail_names = [
  "Sunset Rum Splash",
  "Bourbon Bliss",
  "Vodka Vortex",
  "Gin Genie",
  "Whiskey Wonderland",
  "Tequila Sunrise",
  "Vermouth Velvet",
  "Apricot Dream"
]

cocktail_names.each do |name|
  Cocktail.create!(
    name: name
  )
end

puts "Created #{Cocktail.count} cocktails!"
puts "Creating doses..."

doses_description = ["a dash", "a spoonful", "half a cup", "rim of cup", "a pinch", "a dollop", "a handful", "a splash", "a sprinkle", "a scoop", "a ladleful", "a smidgen", "a drop", "a heaping tablespoon"]

Cocktail.all.each do |cocktail|
  2..5.times do
    cocktail.doses.create!(
      description: doses_description.sample,
      ingredient: Ingredient.all.sample
    )
  end
end

puts "Created #{Dose.count} doses!"
