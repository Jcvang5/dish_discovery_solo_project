# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe_history
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = @recipe_history.recipes.build(recipe_params)

    # find the recipe_history through params, similar to comments controller
    # then create @receipe through the association @receipe_history.receipe.create(receipe_params)

    respond_to do |format|
      if @recipe.save
        format.html do
          redirect_to recipe_history_recipe_path(@recipe_history, @recipe), notice: 'Recipe was successfully created.'
        end
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html do
          redirect_to recipe_history_recipe_path(@recipe_history, @recipe), notice: 'Recipe was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_recipe_history
    @recipe = @recipe_history.recipes.find(params[:id])
    @recipe.destroy!

    respond_to do |format|
      format.html do
        redirect_to recipe_history_recipes_path(@recipe_history), notice: 'Recipe was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_recipe_history
    @recipe_history = RecipeHistory.find(params[:recipe_history_id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :ingredients)
  end
end
