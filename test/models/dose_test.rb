require 'test_helper'

class DoseTest < ActiveSupport::TestCase
  fixtures :doses, :cocktails, :ingredients

  test "should save dose with description, cocktail, and ingredient" do
    dose = Dose.new(description: "A new dose", cocktail: cocktails(:martini), ingredient: ingredients(:mint))
    assert dose.save, "Failed to save the dose with valid attributes"
  end

  test "should not save dose without cocktail" do
    dose = Dose.new(description: "A dash", ingredient: ingredients(:lime))
    assert_not dose.save, "Saved the dose without a cocktail"
  end

  test "should not save dose without ingredient" do
    dose = Dose.new(description: "A dash", cocktail: cocktails(:mojito))
    assert_not dose.save, "Saved the dose without an ingredient"
  end

  test "should not save dose with duplicate [cocktail, ingredient] pairing" do
    duplicate_dose = Dose.new(description: "A splash", cocktail: cocktails(:mojito), ingredient: ingredients(:lime))
    assert_not duplicate_dose.save, "Saved the dose with a duplicate [cocktail, ingredient] pairing"
  end
end
