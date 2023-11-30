class AddRecipeHistoryReferenceToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :recipe_history, foreign_key: true
  end
end
