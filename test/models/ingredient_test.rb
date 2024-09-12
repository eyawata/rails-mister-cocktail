require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  fixtures :ingredients

  test "should not save ingredient without unique name" do
    duplicate_ingredient = Ingredient.new(name: ingredients(:lime).name)
    assert_not duplicate_ingredient.save, "Saved the ingredient with a duplicate name"
  end
end
