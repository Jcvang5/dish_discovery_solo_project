# frozen_string_literal: true

json.extract! recipe_history, :id, :user_id, :created_at, :updated_at
json.url recipe_history_url(recipe_history, format: :json)
