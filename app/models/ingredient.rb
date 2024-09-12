class Ingredient < ApplicationRecord
  validates :name, uniqueness: true

  has_many :doses
end
