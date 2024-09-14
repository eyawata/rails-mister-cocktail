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

doses_description = ["dash", "spoonful", "half a cup", "rim of cup", "pinch", "dollop", "handful", "splash", "sprinkle", "scoop", "ladleful", "smidgen", "drop", "heaping tablespoon"]

Cocktail.all.each do |cocktail|
  used_ingredients = []

  rand(2..5).times do
    # Get available ingredients that have not been used with this cocktail
    available_ingredients = Ingredient.where.not(id: used_ingredients)

    break if available_ingredients.empty?

    ingredient = available_ingredients.sample

    cocktail.doses.create!(
      description: doses_description.sample,
      ingredient: ingredient
    )

    used_ingredients << ingredient.id
  end
end

puts "Created #{Dose.count} doses!"
