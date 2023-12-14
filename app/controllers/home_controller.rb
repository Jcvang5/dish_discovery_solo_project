# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_gon_variables
  def index; end

  def set_gon_variables
    gon.env_variables = {
      SPOONACULAR_API_KEY: ENV['SPOONACULAR_API_KEY']
    }
  end
end
