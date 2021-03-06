class Ingredient < ActiveRecord::Base
  has_many :user_ingredients
  has_many :cocktail_ingredients
  has_many :users, through: :user_ingredients
  has_many :cocktails, through: :cocktail_ingredients

  def self.get_names
    self.all.collect do |ingredient|
      ingredient.name
    end.sort
  end
end
