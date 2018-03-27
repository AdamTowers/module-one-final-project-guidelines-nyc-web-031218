class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :user_ingredients
  has_many :cocktails, through: :user_cocktails
  has_many :ingredients, through: :user_ingredients


  def add_ingredient(ingredient_string)
    new_ingredient = Ingredient.create_or_find_by(name: ingredient_string.downcase)
    unless self.ingredients.include?(new_ingredient)
      self.ingredients << new_ingredient
    end
  end



end
