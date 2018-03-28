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
      if ci.amount == nil || ci.amount.strip == ""
        puts ci.ingredient.name
      else
        puts "#{ci.amount.strip} - #{ci.ingredient.name}"
      end
    end
    puts "Instructions:"
    puts searched_cocktail.instructions
    puts "---"
  end

  def self.create_cocktail(cocktail_name)
    new_cocktail = Cocktail.create(name: cocktail_name)
    puts "Please enter all the ingredients, seperated by commas."
    puts "(Example: Vodka, Orange Juice, Ice)"
    new_ingredients = gets.chomp.downcase.split(/\s*,\s*/)
    new_ingredients.each do |i|
      current = Ingredient.find_or_create_by(name: i)
      new_cocktail.ingredients << current
    end
    new_cocktail.cocktail_ingredients.each do |ci|
      puts "Please enter the amount for #{ci.ingredient.name}"
      ci.amount = gets.chomp.downcase
      ci.save
    end
    puts "Please enter the cocktail instructions:"
    new_cocktail.instructions = gets.chomp
    new_cocktail.save
    puts "Your cocktail has been added!"
  end

end
