class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :user_ingredients
  has_many :cocktails, through: :user_cocktails
  has_many :ingredients, through: :user_ingredients


  def add_ingredient(ingredient_string)
    new_ingredient = Ingredient.find_or_create_by(name: ingredient_string.downcase)
    if self.ingredients.include?(new_ingredient)
      puts "This ingredient is already in your inventory."
    else
      self.ingredients << new_ingredient
      puts "Added #{new_ingredient} to your inventory."
    end
  end

  def add_cocktail(cocktail_string)
    new_cocktail = Cocktail.find_by(name: cocktail_string.downcase)
    if self.cocktails.include?(new_cocktail)
      puts "This cocktail has already been added to your favorites."
    elsif new_cocktail
      self.cocktails << new_cocktail
      puts "Added #{new_cocktail} to your favorites."
    else
      puts "We didn't find that cocktail."
    end
  end

  def get_item_names(type)
    if type == "ingredients"
      items = self.ingredients.collect{|e| e.name.titleize}
    elsif type == "cocktails"
      items = self.cocktails.collect{|e| e.name.titleize}
    else
      puts 'error with item names'
    end
    if items.size > 0
      puts items
    else
      puts "You havent saved any #{type} yet."
    end
  end

  def get_possible_drinks
   drinks =self.ingredients.collect do |ingredient|
      ingredient.cocktails.collect do |cocktail|
        cocktail.name
      end
    end
    drinks.flatten.uniq.sort
  end

end
