require_relative '../config/environment'

def main_menu
  puts "Please enter one of the following commands"
  # puts "- All ingredients : display all ingredients"
  # puts "- All cocktails : display all cocktails"
  puts "- Inventory : display all your currently saved ingredients"
  puts "- Add Ingredient : saves an ingredient to your inventory"
  puts "- Favorites : display all your currently saved cocktails"
  puts "- Add Cocktail : saves a cocktail to your favorites"
  puts "- My Options : displays cocktails possible with your inventory"
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
    puts "Welcome, #{current_user.name.capitalize}"
  end

  while input
    main_menu
    input = gets.chomp.downcase
    case input
    when 'inventory'
      puts "Your current inventory includes: "
      current_user.get_item_names("ingredients")
    when 'add ingredient'
      puts 'Please enter the name of the ingredient you would like to save.'
      input = gets.chomp.downcase
      current_user.add_ingredient(input)
    when 'favorites'
      puts "Your currently saved cocktails are: "
      current_user.get_item_names("cocktails")
    when 'add cocktail'
      puts 'Please enter the name of the cocktail you would like to save.'
      input = gets.chomp.downcase
      current_user.add_cocktail(input)
    when 'my options'
      puts current_user.get_possible_drinks
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
