# frozen_string_literal: true

class CreateRecipeHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_histories do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
