# frozen_string_literal: true

class RecipeHistory < ApplicationRecord
  belongs_to :user
  has_many :recipes
end
