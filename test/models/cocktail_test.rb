require 'test_helper'

class CocktailTest < ActiveSupport::TestCase
  fixtures :cocktails

  test "should not save cocktail without unique name" do
    duplicate_cocktail = Cocktail.new(name: cocktails(:mojito).name)
    assert_not duplicate_cocktail.save, "Saved the cocktail with a duplicate name"
  end

  test "should have many doses" do
    mojito = cocktails(:mojito)
      assert_equal 2, mojito.doses.count
  end

  test "should have many ingredients through doses" do
    mojito = cocktails(:mojito)
      assert_equal 2, mojito.ingredients.count
  end

  test "should delete associated doses when cocktail is deleted" do
    mojito = cocktails(:mojito)
    assert_difference('Dose.count', -2) do
      mojito.destroy
    end
  end

  test "should not delete associated ingredients when cocktail is deleted" do
    mojito = cocktails(:mojito)
    lime = ingredients(:lime)
    mojito.destroy
    assert Ingredient.exists?(lime.id), "Ingredient should not be deleted when cocktail is deleted"
  end
end
