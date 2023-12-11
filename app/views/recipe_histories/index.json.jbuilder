# frozen_string_literal: true

json.array! @recipe_histories, partial: 'recipe_histories/recipe_history', as: :recipe_history
