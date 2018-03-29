class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :user_ingredients
  has_many :cocktails, through: :user_cocktails
  has_many :ingredients, through: :user_ingredients


  def add_ingredient(ingredient_string)
    new_ingredient = Ingredient.find_or_create_by(name: ingredient_string.downcase)
    if self.ingredients.include?(new_ingredient)
      puts "This ingredient is already in your inventory.".white.on_red
    else
      self.ingredients << new_ingredient
      puts "Added #{new_ingredient.name} to your inventory.".white.on_green
    end
  end

  def add_cocktail(cocktail_string)
    new_cocktail = Cocktail.find_by(name: cocktail_string.downcase)
    if self.cocktails.include?(new_cocktail)
      puts "This cocktail has already been added to your favorites.".white.on_red
    elsif new_cocktail
      self.cocktails << new_cocktail
      puts "Added #{new_cocktail.name} to your favorites.".white.on_green
    else
      puts "We didn't find that cocktail.".white.on_red
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
      puts "You havent saved any #{type} yet.".white.on_red
    end
  end

  def get_possible_drinks
    drinks = []
    self.ingredients.each do |ingredient|
      ingredient.cocktails.each do |cocktail|
        ct_name = cocktail.name
        user_ingredient_count = (self.ingredients & cocktail.ingredients).length
        ingredient_count = cocktail.ingredients.length
        drinks << [ct_name, user_ingredient_count, ingredient_count]
      end
    end
    drinks = drinks.uniq.sort{|a,b| a[1].to_f/a[2] <=> b[1].to_f/b[2]}
  end

  def delete_ingredient(ingredient_to_delete)
    selected_ingredient = self.ingredients.find_by(name: ingredient_to_delete)
    if self.ingredients.include?(selected_ingredient)
      self.ingredients.destroy(selected_ingredient)
      puts "You've deleted #{ingredient_to_delete} from your inventory.".white.on_green
    else
      puts "You don't have #{ingredient_to_delete} in your inventory.".white.on_red
    end
  end

  def give_rating(cocktail, user_rating)
    cocktail_object = Cocktail.find_by(name: cocktail)
    if cocktail_object
      UserCocktail.create(user_id: self.id, cocktail_id: cocktail_object.id, rating: user_rating)
    else
      puts "Cocktail not found.".white.on_red
    end
  end
end
