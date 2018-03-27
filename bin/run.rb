require_relative '../config/environment'

def main_menu
  puts "Please enter one of the following commands"
  # puts "- All ingredients : display all ingredients"
  # puts "- All cocktails : display all cocktails"
  puts "- My Inventory : display all your currently saved ingredients"
  puts "- Add To Inventory : add an ingredient to your personal inventory"
  puts "- My Cocktails : display all cocktails you have saved"
  puts "- My Options : displays cocktails possible with your inventory"
  puts "- Exit : quit this program"
end

def my_inventory (current_user)
  inventory = current_user.ingredients.collect {|e| e.name}
  if inventory.size > 0
    puts inventory
  else
    puts "You haven't added any ingredients to your inventory."
  end
end

def my_cocktails (current_user)
  cocktails = current_user.cocktails.collect {|e| e.name}
  if cocktails.size > 0
    puts cocktails
  else
    puts "You haven't saved any cocktails yet."
  end
end

def run
  system "clear"
  puts cocktail_art
  puts "Welcome to your personal bar."
  puts "Please input your name:"
  name_response = gets.chomp.downcase
  current_user = User.find_or_create_by(name: name_response)
  puts "Welcome, #{current_user.name.capitalize}"

  input = ""
  while input
    main_menu
    input = gets.chomp.downcase
    case input
    when 'my inventory'
      my_inventory(current_user)
      #call that method
    when 'add to inventory'
      #etc
    when 'my cocktails'
      my_cocktails(current_user)
      #etc
    when 'my options'
      #etc
    when 'exit'
      puts "Goodbye"
      break
    else
      system "clear"
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
