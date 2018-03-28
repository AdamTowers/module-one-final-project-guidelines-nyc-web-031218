class Cocktail < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktail_ingredients
  has_many :users, through: :user_cocktails
  has_many :ingredients, through: :cocktail_ingredients

  def self.get_names
    self.all.collect do |cocktail|
      cocktail.name
    end.sort
  end

  def self.get_info(cocktail_name)
    searched_cocktail = Cocktail.find_by(name: cocktail_name)
    puts "---"
    puts "How to Make: #{searched_cocktail.name.titleize}"
    puts "Ingredients:"
    searched_cocktail.cocktail_ingredients.each do |ci|
      if ci.amount.strip == "" || ci.amount == nil
        puts ci.ingredient.name
      else
        puts "#{ci.amount}- #{ci.ingredient.name}"
      end
    end
    puts "Instructions:"
    puts searched_cocktail.instructions
    puts "---"
  end
end
