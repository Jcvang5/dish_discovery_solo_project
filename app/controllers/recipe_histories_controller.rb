# frozen_string_literal: true

class RecipeHistoriesController < ApplicationController
  before_action :set_recipe_history, only: %i[show edit update destroy]

  # GET /recipe_histories or /recipe_histories.json
  def index
    @recipe_histories = RecipeHistory.all
  end

  # GET /recipe_histories/1 or /recipe_histories/1.json
  def show
    @recipe_history = RecipeHistory.find(params[:id])
    @recipe = @recipe_history.recipes
  end

  # GET /recipe_histories/new
  def new
    @recipe_history = RecipeHistory.new
  end

  # GET /recipe_histories/1/edit
  def edit; end

  # POST /recipe_histories or /recipe_histories.json
  def create
    @recipe_history = RecipeHistory.new(recipe_history_params)

    respond_to do |format|
      if @recipe_history.save
        format.html do
          redirect_to recipe_history_url(@recipe_history), notice: 'Recipe history was successfully created.'
        end
        format.json { render :show, status: :created, location: @recipe_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_histories/1 or /recipe_histories/1.json
  def update
    respond_to do |format|
      if @recipe_history.update(recipe_history_params)
        format.html do
          redirect_to recipe_history_url(@recipe_history), notice: 'Recipe history was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @recipe_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_histories/1 or /recipe_histories/1.json
  def destroy
    @recipe_history.destroy!

    respond_to do |format|
      format.html { redirect_to recipe_histories_url}
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_history
    @recipe_history = RecipeHistory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_history_params
    params.require(:recipe_history).permit(:user_id)
  end
end
