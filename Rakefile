require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  vodka = Ingredient.find_by(name: "vodka")
  whiskey = Ingredient.find_by(name: "whiskey")
  belmont = Cocktail.find_by(name: "155 belmont")
  white_russian = Cocktail.find_by(name: "white russian")
  binding.pry
  "hi"
end
