# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :recipe_history
end
