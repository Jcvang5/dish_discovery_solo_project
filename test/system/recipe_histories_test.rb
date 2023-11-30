require "application_system_test_case"

class RecipeHistoriesTest < ApplicationSystemTestCase
  setup do
    @recipe_history = recipe_histories(:one)
  end

  test "visiting the index" do
    visit recipe_histories_url
    assert_selector "h1", text: "Recipe histories"
  end

  test "should create recipe history" do
    visit recipe_histories_url
    click_on "New recipe history"

    fill_in "User", with: @recipe_history.user_id
    click_on "Create Recipe history"

    assert_text "Recipe history was successfully created"
    click_on "Back"
  end

  test "should update Recipe history" do
    visit recipe_history_url(@recipe_history)
    click_on "Edit this recipe history", match: :first

    fill_in "User", with: @recipe_history.user_id
    click_on "Update Recipe history"

    assert_text "Recipe history was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipe history" do
    visit recipe_history_url(@recipe_history)
    click_on "Destroy this recipe history", match: :first

    assert_text "Recipe history was successfully destroyed"
  end
end
