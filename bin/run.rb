require_relative '../config/environment'

def login
  puts "Please enter one of the following commands:".yellow
  puts "Login".yellow + ": login with your existing username"
  puts "Create Account".yellow + ": create a new user account"
end

def main_menu
  puts "Please enter one of the following commands:".yellow
  puts "Inventory".yellow + ": display all your currently saved ingredients"
  puts "Favorites".yellow + ": display all your currently saved cocktails"
  puts "Options".yellow + ": display cocktails possible with your inventory"
  puts "Add Ingredient".yellow + ": save an ingredient to your inventory"
  puts "Remove Ingredient".yellow + ": remove ingredient from your inventory"
  puts "Add Cocktail".yellow + ": save a cocktail to your favorites"
  puts "Remove Cocktail".yellow + ": remove cocktail from your favorites"
  puts "Search Cocktail".yellow + ": display ingredients and instructions for a specific cocktail"
  puts "Create Cocktail".yellow + ": share a new cocktail recipe"
  puts "Review Cocktail".yellow + ": submit review for specific cocktail"
  puts "Update Cocktail".yellow + ": change details about a specific cocktail"
  puts "Cocktail Roulette".yellow + ": display ingredients and instrutions for a random cocktail"
  puts "Exit".red + ": quit this program"
end

def main_menu2
  {
    ("Inventory".yellow + ": display all your currently saved ingredients") => "inventory",
    ("Favorites".yellow + ": display all your currently saved cocktails") => "favorites",
    ("Options".yellow + ": display cocktails possible with your inventory") => "options",
    ("Add Ingredient".yellow + ": save an ingredient to your inventory") => "add ingredient",
    ("Remove Ingredient".yellow + ": remove ingredient from your inventory") => "remove ingredient",
    ("Add Cocktail".yellow + ": save a cocktail to your favorites") => "add cocktail",
    ("Remove Cocktail".yellow + ": remove cocktail from your favorites") => "remove cocktail",
    ("Search Cocktail".yellow + ": display ingredients and instructions for a specific cocktail") => "search cocktail",
    ("Create Cocktail".yellow + ": share a new cocktail recipe") => "create cocktail",
    ("Review Cocktail".yellow + ": submit review for specific cocktail") => "review cocktail",
    ("Update Cocktail".yellow + ": change details about a specific cocktail") => "update cocktail",
    ("Cocktail Roulette".yellow + ": display ingredients and instrutions for a random cocktail") => "cocktail roulette",
    ("Exit".red + ": quit this program") => "exit"
  }
end

def run
  prompt = TTY::Prompt.new
  system "clear"
  puts cocktail_art.blue.blink
  puts "Welcome to your personal bar.".white.on_blue
  response = ""
  input = ""

  while response
    login
    response = gets.chomp.downcase
    case response

    when "exit"
      puts "Goodbye".white.on_blue
      input = nil
      puts "==================="
      puts
      break

    when "login"
      username_input = prompt.ask("Please enter your username:".yellow, required: true)
      current_user = User.find_by(username: username_input)
      if current_user
        puts "Welcome, #{current_user.name.titleize}".white.on_blue
        puts "==================="
        break
      else
        system "clear"
        puts "Sorry, that username doesn't exist.".white.on_red
      end

    when "create account"
      # puts "Please enter your desired username:".yellow
      # username_request = gets.chomp
      username_request = prompt.ask("Please enter your desire username:".yellow, required: true)
      if User.find_by(username: username_request)
        system "clear"
        puts "Sorry, that username already exists.".white.on_red
      else
        # puts "Please enter your name".yellow
        # new_users_name =  gets.chomp
        new_users_name = prompt.ask("Please enter your name".yellow, required: true)
        current_user = User.create(username: username_request, name: new_users_name)
        puts "Welcome, #{current_user.name.titleize}".white.on_blue
        puts "==================="
        break
      end

    else
      system "clear"
      puts "I'm sorry, that was not a valid command.".white.on_red
      puts "==================="
    end
  end

  while input
    # main_menu
    # input = gets.chomp.downcase
    input = prompt.select("What would you like to do?", main_menu2, cycle: true)
    case input

    when 'inventory'
      system "clear"
      puts "Your current inventory includes: ".white.on_blue if current_user.ingredients.length > 0
      current_user.get_item_names("ingredients")
      puts "==================="

    when 'add ingredient'
      system "clear"
      puts "Please enter the name of the ingredient you would like to save:".yellow
      input = gets.chomp.downcase
      current_user.add_ingredient(input)
      puts "==================="

    when 'remove ingredient'
      system "clear"
      puts "The following items are currently in your inventory".yellow
      current_user.get_item_names("ingredients")
      puts "Please enter the name of the ingredient you would like to delete:".yellow
      selected_ingredient = gets.chomp.downcase
      current_user.delete_ingredient(selected_ingredient)
      puts ""
      puts "==================="

    when 'favorites'
      system "clear"
      puts "Your currently saved cocktails are: ".white.on_blue if current_user.cocktails.length > 0
      current_user.get_item_names("cocktails")
      puts "==================="

    when 'add cocktail'
      system "clear"
      puts "Please enter the name of the cocktail you would like to save:".yellow
      input = gets.chomp.downcase
      current_user.add_cocktail(input)

    when 'remove cocktail'
      system "clear"
      puts "The following cocktails are currently on your favorites".yellow
      current_user.get_item_names("cocktails")
      puts "Please enter the name of the cocktail you would like to remove from your favorites.".yellow
      response = gets.chomp.downcase
      cocktail = Cocktail.find_by(name: response)
      if response && current_user.cocktails.include?(cocktail)
        current_user.cocktails.destroy(cocktail)
        puts "#{cocktail.name.titleize} has been removed from your favorites".white.on_green
      else
        puts "We didn't that cocktail in your favorites".white.on_red
      end
      puts "==================="



    when 'options'
      system "clear"
      results = current_user.get_possible_drinks
      results.each do |sub_array|
        string1 = "#{sub_array[0].titleize}: "
        string2 = "You have #{sub_array[1]}/#{sub_array[2]} ingredients."
        #changes the colors of results depending on percentage of available ingredients
        if sub_array[1] == sub_array[2]
          puts string1 + string2.green
        elsif sub_array[1].to_f/sub_array[2] >= 0.5
          puts string1 + string2.yellow
        else
          puts string1 + string2.light_red
        end
      end
      puts "==================="

    when 'search cocktail'
      system "clear"
      puts "What cocktail would you like to look up?".yellow
      searched_cocktail = gets.chomp.downcase
      Cocktail.get_info(searched_cocktail)
      puts "==================="

    when 'cocktail roulette'
      system 'clear'
      #randomizes the cocktails and grabs one element
      random_cocktail = Cocktail.order("RANDOM()").first
      Cocktail.get_info(random_cocktail.name)
      puts "==================="

    when 'create cocktail'
      system "clear"
      puts "Please input the name of the cocktail you'd like to create:".yellow
      input = gets.chomp.downcase
      if Cocktail.get_names.include?(input)
        puts "I'm sorry, a cocktail already exists with that name".white.on_red
      else
        Cocktail.create_cocktail(input)
      end
      puts "==================="

    when 'review cocktail'
      system "clear"
      puts "What cocktail would you like to review?".yellow
      cocktail_name = gets.chomp.downcase
      puts "What rating would you like to give it (1-10)?".yellow
      user_rating = gets.chomp
      if user_rating.to_i.to_s == user_rating && (1..10).include?(user_rating.to_i)
        current_user.give_rating(cocktail_name, user_rating)
        puts "Thank you for your review.".white.on_green
      else
        puts "You did not enter a valid rating.".white.on_red
      end

    when 'update cocktail'
      system "clear"
      puts "Which cocktail would you like to update?".yellow
      query = gets.chomp.downcase
      cocktail = Cocktail.find_by(name: query)
      if cocktail
        cocktail.update_cocktail
      else
        puts "We did not find a cocktail with that name.".white.on_red
      end
      puts "==================="
      puts

    when 'exit'
      puts "Goodbye".white.on_blue
      puts "==================="
      break

    else
      system "clear"
      puts "I'm sorry, that was not a valid command.".white.on_red
      puts "==================="
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
