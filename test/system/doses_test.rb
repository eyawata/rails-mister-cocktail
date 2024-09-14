require "application_system_test_case"

class DosesTest < ApplicationSystemTestCase
  fixtures :cocktails, :doses, :ingredients

  def setup
    @cocktail = cocktails(:mojito)
    @ingredient = ingredients(:syrup)
  end

  test "user can create a new dose" do
    visit cocktail_path(@cocktail)

    # Select the ingredient from the dropdown
    select @ingredient.name, from: "Ingredient"

    # Fill in the description
    fill_in "Description", with: "A dollop of"

    # Click the 'Create Dose' button
    click_button "Create Dose"

    # Verify that we're back on the cocktail page
    assert_current_path cocktail_path(@cocktail)

    # Check that the new dose is displayed on the page
    assert_text @ingredient.name
    assert_text "A dollop of"
  end
end
