require "test_helper"

class RecipeHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe_history = recipe_histories(:one)
  end

  test "should get index" do
    get recipe_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_history_url
    assert_response :success
  end

  test "should create recipe_history" do
    assert_difference("RecipeHistory.count") do
      post recipe_histories_url, params: { recipe_history: { user_id: @recipe_history.user_id } }
    end

    assert_redirected_to recipe_history_url(RecipeHistory.last)
  end

  test "should show recipe_history" do
    get recipe_history_url(@recipe_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_history_url(@recipe_history)
    assert_response :success
  end

  test "should update recipe_history" do
    patch recipe_history_url(@recipe_history), params: { recipe_history: { user_id: @recipe_history.user_id } }
    assert_redirected_to recipe_history_url(@recipe_history)
  end

  test "should destroy recipe_history" do
    assert_difference("RecipeHistory.count", -1) do
      delete recipe_history_url(@recipe_history)
    end

    assert_redirected_to recipe_histories_url
  end
end
