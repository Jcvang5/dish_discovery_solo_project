class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :instructions
      t.text :ingredients

      t.timestamps
    end
  end
end
