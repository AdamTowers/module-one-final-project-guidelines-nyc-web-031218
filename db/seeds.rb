require_relative '../config/environment.rb'

ingredients_url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
id_lookup_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="

drink_ingredients = ["vodka", "tequila", "whiskey", "whisky", "rum", "gin", "cognac",
   "triple sec", "blue curacao", "dark rum", "light rum",
   "white rum", "coconut rum", "orange juice", "salt", "ice", "water", "club soda"
]

id_array = []
drink_ingredients.each do |ingredient|
  results = RestClient.get(ingredients_url + ingredient)
  json_results = JSON.parse(results) if results
  json_results["drinks"].each do |drink|
    id_array << drink["idDrink"]
  end
end

id_array.uniq!

id_array.each do |id|
  results = RestClient.get(id_lookup_url + id)
  json_results = JSON.parse(results)
  json_results["drinks"].each do |drink|
    current_cocktail = Cocktail.find_or_create_by(name: drink["strDrink"].downcase, instructions: drink["strInstructions"])
    (1..15).each do |number|
      unless drink["strIngredient"+number.to_s] == "" || drink["strIngredient"+number.to_s] == " " || drink["strIngredient"+number.to_s] == nil
        current_ingredient = Ingredient.find_or_create_by(name: drink["strIngredient"+number.to_s].downcase)
        CocktailIngredient.find_or_create_by(amount: drink["strMeasure"+number.to_s], cocktail_id: current_cocktail.id, ingredient_id: current_ingredient.id)
      end
    end
  end
end


binding.pry
"Hello, Adam"
