class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :user_ingredients
  has_many :cocktails, through: :user_cocktails
  has_many :ingredients, through: :user_ingredients


  # def add_ingredient(ingredient_string)
  #   new_ingredient = Ingredient.find_or_create_by(name: ingredient_string.downcase)
  #   unless self.ingredients.include?(new_ingredient)
  #     self.ingredients << new_ingredient
  #   end
  # end


  def add_item(query_string, type)
    if type == "ingredient"
      new_ingredient = Ingredient.find_or_create_by(name: query_string.downcase)
      unless self.ingredients.include?(new_ingredient)
        self.ingredients << new_ingredient
      end
    elsif type == "cocktail"
      new_cocktail = Cocktail.find_or_create_by(name: query_string.downcase)
      unless self.cocktails.include?(new_cocktail)
        self.cocktails << new_cocktail
      end
    else
      puts "error in add item"
    end
  end

  def get_item_names(type)
    if type == "ingredients"
      items = self.ingredients.collect{|e| e.name.capitalize}
    elsif type == "cocktails"
      items = self.cocktails.collect{|e| e.name.capitalize}
    else
      puts 'error with item names'
    end
    if items.size > 0
      puts items
    else
      puts "You havent saved any #{type} yet."
    end
  end


end
