require 'test_helper'

class CocktailsControllerTest < ActionDispatch::IntegrationTest
  fixtures :cocktails, :doses, :ingredients

  # Test for listing cocktails
  test "should get index" do
    get cocktails_url
    assert_response :success
    assert_select 'h1', 'Cocktails'
    assert_select 'li', cocktails(:mojito).name
    assert_select 'li', cocktails(:martini).name
  end

  # Test for showing cocktail details
  test "should show cocktail" do
    mojito = cocktails(:mojito)
    get cocktail_url(mojito)
    assert_response :success
    assert_select 'h1', mojito.name
    assert_select 'li', doses(:mojito_lime).description
    assert_select 'li', doses(:mojito_mint).description
  end

  # Test for creating a new cocktail
  test "should create cocktail" do
    assert_difference('Cocktail.count') do
      post cocktails_url, params: { cocktail: { name: 'New Cocktail' } }
    end
    assert_redirected_to cocktail_path(Cocktail.last)
  end
end
