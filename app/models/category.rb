class Category < ApplicationRecord
  has_many :bulletins, dependent: :nullify

  validates :name, presence: true, uniqueness: true, length: { in: 2..30 }
end
