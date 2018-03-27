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
end
