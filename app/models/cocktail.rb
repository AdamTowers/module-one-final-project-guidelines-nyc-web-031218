class Cocktail < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktail_ingredients
  has_many :users, through: :user_cocktails
  has_many :ingredients, through: :cocktail_ingredients

  def update_cocktail
    input = ""
    while (input)
      puts "You are now editing the cocktail #{self.name.titleize}".yellow
      puts "What would you like to change?".yellow
      puts "You can type: name, ingredients, instructions".yellow
      puts "When you are finished, type exit".yellow
      input = gets.chomp.downcase
      case input
      when "name"
        puts "Current name is: #{self.name.titleize}".yellow
        puts "What would you like to change this to?".yellow
        self.update(name: gets.chomp.downcase)
      when "ingredients"
        self.cocktail_ingredients.clear
        binding.pry
        puts "Please enter all the ingredients for this recipe, seperated by commas.".yellow
        puts "(Ex: bananas, vodka, pineapple juice, ice)".yellow
        new_ingredients = gets.chomp.downcase.split(/\s*,\s*/)
        new_ingredients.each do |i|
          current = Ingredient.find_or_create_by(name: i)
          self.ingredients << current
        end
        self.cocktail_ingredients.each do |ci|
          puts "Please enter the amount for #{ci.ingredient.name}".yellow
          ci.update(amount: gets.chomp.downcase)
        end

      when "instructions"
        puts "The instructions for #{self.name} are as follows"
        puts self.instructions
        puts "What would you like to change the instructions to?"
        self.update(instructions: gets.chomp)
        puts "The instructions have been updated."
      when "exit"
        input = nil
      else
        system "clear"
        puts "I'm sorry, that was not a correct command, please try again.".white.on_red
      end
    end
  end

  def self.get_names
    self.all.collect do |cocktail|
      cocktail.name
    end.sort
  end

  def find_rating
    if self.user_cocktails == []
      puts "No ratings yet.".red
    else
      rating_total = self.user_cocktails.reduce(0) do |sum, element|
        element.rating ? sum + element.rating : sum
      end
      if rating_total > 0
        average = rating_total.to_f / self.user_cocktails.count(:rating)
      else
        puts "No ratings yet.".red
      end
    end
  end

  def self.get_info(cocktail_name, user)
    searched_cocktail = Cocktail.find_by(name: cocktail_name)
    checkmark = "\u2713"
      if searched_cocktail
      puts "==================="
      puts "#{searched_cocktail.name.titleize}".white.on_blue
      puts "Ingredients:".blue
      searched_cocktail.cocktail_ingredients.each do |ci|
        if ci.amount == nil || ci.amount.strip == ""
          string = ci.ingredient.name.titleize
          string += " #{checkmark.force_encoding('utf-8')}" if user.ingredients.include?(ci.ingredient)
          puts string
        else
          string = "#{ci.amount.strip} - #{ci.ingredient.name.titleize}"
          string += " #{checkmark.force_encoding('utf-8')}" if user.ingredients.include?(ci.ingredient)
          puts string
        end
      end
      puts "Instructions:".blue
      puts searched_cocktail.instructions
      puts "Rating:".blue
      puts searched_cocktail.find_rating
    else
      puts "I'm sorry, we didn't find a cocktail with the name: #{cocktail_name}".white.on_red
    end
  end

  def self.create_cocktail(cocktail_name)
    new_cocktail = Cocktail.create(name: cocktail_name)
    puts "Please enter all the ingredients, seperated by commas.".yellow
    puts "(Example: Vodka, Orange Juice, Ice)".yellow
    new_ingredients = gets.chomp.downcase.split(/\s*,\s*/)
    new_ingredients.each do |i|
      current = Ingredient.find_or_create_by(name: i)
      new_cocktail.ingredients << current
    end
    new_cocktail.cocktail_ingredients.each do |ci|
      puts "Please enter the amount for #{ci.ingredient.name}".yellow
      ci.update(amount: gets.chomp.downcase)
    end
    puts "Please enter the cocktail instructions:".yellow
    new_cocktail.instructions = gets.chomp
    new_cocktail.save
    puts "Your cocktail has been added!".white.on_green
  end

end
