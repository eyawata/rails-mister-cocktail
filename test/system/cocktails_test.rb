require "application_system_test_case"

class CocktailsTest < ApplicationSystemTestCase
  fixtures :cocktails, :doses, :ingredients

  # Test for listing cocktails
  test "should get index" do
    visit cocktails_path
    assert_selector 'h1', text: "Cocktails"
    assert_selector 'li', text: cocktails(:mojito).name
    assert_selector 'li', text: cocktails(:martini).name
  end

  # Test for showing cocktail details
  test "should show cocktail" do
    mojito = cocktails(:mojito)

    visit cocktail_path(mojito)

    assert_selector 'h1', text: mojito.name

    desc1 = doses(:mojito_lime).description
    desc2 = doses(:mojito_mint).description

    assert_text desc1
    assert_text desc2
  end

  # Test for creating a new cocktail
  test "user can create a new cocktail" do
    visit cocktails_path

    fill_in 'Name', with: 'Bloody Mary'

    click_on 'Create Cocktail'

    assert_current_path cocktail_path(Cocktail.last)
  end


  # Test for celeting a cocktail
  test "user can delete a cocktail" do
    visit cocktails_path

    @cocktail = cocktails(:mojito)

    within(:xpath, "//li[contains(., '#{@cocktail.name}') or contains(text(), '#{@cocktail.name}')]") do
      find('a[data-turbo-method="delete"]').click
    end

    assert_current_path cocktails_path

    assert_no_text @cocktail.name
  end
end
