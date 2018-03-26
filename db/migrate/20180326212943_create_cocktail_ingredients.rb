class CreateCocktailIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :cocktail_ingredients do |t|
      t.string :amount
      t.integer :cocktail_id
      t.integer :ingredient_id
    end
  end
end
