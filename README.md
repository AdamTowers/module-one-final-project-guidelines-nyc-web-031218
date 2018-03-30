# Myxology

Congratulations, you're are one of the first users to experience what will soon be the next big thing to disrupt Silicon Valley.

We over at the <i>Myxology</i> offices truly believe that we are making the world a better place, through comprehensive search-oriented CLI programming.

## Overview

Ok, all jokes aside, <i>Myxology</i> is a CLI application created by two students at the Flatiron School in New York, NY. It helps you look up cocktail recipes and see relevant results based off of what ingredients you have available to you.

### Installing gems

1. Enter `bundle install` before running the program to get all the necessary gems.
2. Run `rake db:migrate` to build the database structure.
3. You'll also need to seed your database by runnning `rake db:seed` (this may take a little while).
4. Run the program by selecting `ruby bin/run.rb`.

### Logging In

1. If you haven't already, create a login by selecting `create account`.
2. The program will then prompt you to create a username.
3. If you already have a username, select `login` then type in your username.

### Main Menu

1. Once you're logged in, you will see a menu of options. Scroll down with your arrow keys to reveal more.
2. `Inventory` will show you all items in your inventory. To add items to your inventory, select `add ingredient`. To remove items from your inventory, select `remove ingredient` and then select the name of the ingredient you'd like to remove.
3. `Favorites` will show you all of your saved cocktails. To add a cocktail to your favorites, select `add cocktail` which will ask you to input the cocktail you'd like to add. You can also select `remove cocktail` which will function the same way, asking you which cocktail you'd like to remove.
4. If you aren't sure which cocktail you'd like to add, you can search for a specific cocktail by selecting `search cocktail`, or you can select `options` to see a list of all cocktails that you have ingredients for. When you search for a cocktail, and begin typing, the list will automatically start filtering through the database.
5. You are also able to create your own recipe by selecting `create cocktail`. When you're done, it will be added to our database for other users to interact with. Should you want to make changes to the cocktail you've created, select `update cocktail` which will ask you which part of the cocktail recipe you'd like to update.
6. Should you want to review a cocktail, you can select `review cocktail` which you can rate on a scale of 1-10. Don't enter something other than one of those whole numbers, otherwise it will throw you an error!
7. OMG we also have `cocktail roulette`, which will give you a random cocktail from our database.

### Contributors Guide

We are not taking contributions at this time.

### And that's it!
We really enjoyed working on this project and may very well revisit it again in the future to further improve and expand on.

### Special thanks
We'd like to thank the creators of TheCocktailDB, over at [thecocktaildb.com](https://www.thecocktaildb.com/), for making the massive database of drinks available to students like us.

#### Created by:
Manuel Grullon, manuel.grullon@flatironschool.com<br>
Adam Towers, adam.towers@flatironschool.com
