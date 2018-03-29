require_relative '../config/environment'

def main_menu
  puts "Please enter one of the following commands".green
  puts "- Inventory : display all your currently saved ingredients"
  puts "- Add Ingredient : saves an ingredient to your inventory"
  puts "– Delete Ingredient : delete ingredient from your inventory"
  puts "- Favorites : display all your currently saved cocktails"
  puts "- Add Cocktail : saves a cocktail to your favorites"
  puts "- My Options : displays cocktails possible with your inventory"
  puts "- Search Cocktail : display ingredients and instructions for a specific cocktail"
  puts "– Create Cocktail : share a new cocktail recipe"
  puts "- Exit : quit this program".red
end

def run
  system "clear"
  puts cocktail_art.magenta.blink
  puts "Welcome to your personal bar.".white.on_blue
  puts "Please input your name:".green
  name_response = gets.chomp.downcase
  input = ""

  if name_response == "exit"
    puts "Goodbye".green
    input = nil
  else
    current_user = User.find_or_create_by(name: name_response)
    puts "Welcome, #{current_user.name.titleize}".white.on_blue
  end

  while input
    main_menu
    input = gets.chomp.downcase
    case input

    when 'inventory'
      system "clear"
      puts "Your current inventory includes: ".white.on_blue
      current_user.get_item_names("ingredients")

    when 'add ingredient'
      system "clear"
      puts "Please enter the name of the ingredient you would like to save:".green
      input = gets.chomp.downcase
      current_user.add_ingredient(input)

    when 'delete ingredient'
      system "clear"
      puts "Please enter the name of the ingredient you would like to delete:".green
      selected_ingredient = gets.chomp.downcase
      current_user.delete_ingredient(selected_ingredient)
      puts ""

    when 'favorites'
      system "clear"
      puts "Your currently saved cocktails are: ".white.on_blue
      current_user.get_item_names("cocktails")

    when 'add cocktail'
      system "clear"
      puts "Please enter the name of the cocktail you would like to save:".green
      input = gets.chomp.downcase
      current_user.add_cocktail(input)

    when 'my options'
      system "clear"
      results = current_user.get_possible_drinks
      results.each do |sub_array|
        string = "#{sub_array[0].titleize}: #{sub_array[1]}/#{sub_array[2]} ingredients available."
        #changes the colors of results depending on percentage of available ingredients
        if sub_array[1] == sub_array[2]
          puts string.light_blue
        elsif sub_array[1].to_f/sub_array[2] >= 0.5
          puts string.light_green
        else
          puts string.magenta
        end
      end

    when 'search cocktail'
      system "clear"
      puts "What cocktail would you like to look up?".green
      searched_cocktail = gets.chomp.downcase
      Cocktail.get_info(searched_cocktail)

    when 'create cocktail'
      system "clear"
      puts "Please input the name of the cocktail you'd like to create:".green
      input = gets.chomp.downcase
      if Cocktail.get_names.include?(input)
        puts "I'm sorry, a cocktail already exists with that name".white.on_red
      else
        Cocktail.create_cocktail(input)
      end

    when 'exit'
      puts "Goodbye".white.on_blue
      break
      
    else
      system "clear"
      puts "I'm sorry, that was not a valid command.".white.on_red
    end

  end
end

def cocktail_art
  <<-'EOF'
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
