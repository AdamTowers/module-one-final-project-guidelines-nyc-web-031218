require_relative '../config/environment'

def main_menu
  puts "Please enter one of the following commands"
  puts "- Inventory : display all your currently saved ingredients"
  puts "- Add Ingredient : saves an ingredient to your inventory"
  puts "– Delete Ingredient : delete ingredient from your inventory"
  puts "- Favorites : display all your currently saved cocktails"
  puts "- Add Cocktail : saves a cocktail to your favorites"
  puts "- My Options : displays cocktails possible with your inventory"
  puts "- Search Cocktail : display ingredients and instructions for a specific cocktail"
  puts "– Create Cocktail : share a new cocktail recipe"
  puts "- Exit : quit this program"
end

def run
  system "clear"
  puts cocktail_art
  puts "Welcome to your personal bar."
  puts "Please input your name:"
  name_response = gets.chomp.downcase
  input = ""

  if name_response == "exit"
    puts "Goodbye"
    input = nil
  else
    current_user = User.find_or_create_by(name: name_response)
    puts "Welcome, #{current_user.name.titleize}"
  end

  while input
    main_menu
    input = gets.chomp.downcase
    case input
    when 'inventory'
      puts "Your current inventory includes: "
      current_user.get_item_names("ingredients")
    when 'add ingredient'
      puts "Please enter the name of the ingredient you would like to save:"
      input = gets.chomp.downcase
      current_user.add_ingredient(input)
    when 'delete ingredient'
      puts "Please enter the name of the ingredient you would like to delete:"
      selected_ingredient = gets.chomp.downcase
      current_user.delete_ingredient(selected_ingredient)
      puts ""
    when 'favorites'
      puts "Your currently saved cocktails are: "
      current_user.get_item_names("cocktails")
    when 'add cocktail'
      puts "Please enter the name of the cocktail you would like to save:"
      input = gets.chomp.downcase
      current_user.add_cocktail(input)
    when 'my options'
      puts current_user.get_possible_drinks
    when 'search cocktail'
      puts "What cocktail would you like to look up?"
      searched_cocktail = gets.chomp.downcase
      Cocktail.get_info(searched_cocktail)
    when 'create cocktail'
      puts "Please input the name of the cocktail you'd like to create:"
      input = gets.chomp.downcase
      if Cocktail.get_names.include?(input)
        puts "I'm sorry, a cocktail already exists with that name"
      else
        Cocktail.create_cocktail(input)
      end
    when 'exit'
      puts "Goodbye"
      break
    else
      system "clear"
      puts "I'm sorry, that was not a valid command."
    end

  end
end

def cocktail_art
  puts <<-'EOF'
   \
   .\"""""""""-.
   \`\-------'`/
    \ \__ o . /
     \/  \  o/
      \__/. /
       \_ _/
         Y
         |
         |
     _.-' '-._
    `---------`
  EOF
end

run
