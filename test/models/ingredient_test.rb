require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  fixtures :ingredients

  test "should not save ingredient without unique name" do
    duplicate_ingredient = Ingredient.new(name: ingredients(:lime).name)
    assert_not duplicate_ingredient.save, "Saved the ingredient with a duplicate name"
  end

  test "should have many doses" do
  lime = ingredients(:lime)
    assert_equal 2, lime.doses.count
  end


  test "should delete ingredient if it is not used by any cocktail" do
    lemon = ingredients(:lemon)
    assert_difference('Ingredient.count', -1) do
      assert lemon.destroy, "Failed to delete the ingredient that is not used by any cocktail"
    end
  end
end
