require 'test_helper'

class CocktailTest < ActiveSupport::TestCase
  fixtures :cocktails

  test "should not save cocktail without unique name" do
    duplicate_cocktail = Cocktail.new(name: cocktails(:mojito).name)
    assert_not duplicate_cocktail.save, "Saved the cocktail with a duplicate name"
  end
end
