class Dose < ApplicationRecord
  # A dose must have a description, a cocktail and an ingredient, and [cocktail, ingredient] pairings should be unique.
  validates :description, presence: true
  validates :cocktail, uniqueness: { scope: :ingredient, message: "and ingredient pairing must be unique" }

  belongs_to :cocktail
  belongs_to :ingredient
end
