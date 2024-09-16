class Category < ApplicationRecord
  has_many :bulletins, dependent: :nullify

  validates :name, length: { in: 2..30 }
end
