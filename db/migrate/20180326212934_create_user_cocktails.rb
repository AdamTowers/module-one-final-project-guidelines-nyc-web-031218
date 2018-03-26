class CreateUserCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :user_cocktails do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :cocktail_id
    end
  end
end
