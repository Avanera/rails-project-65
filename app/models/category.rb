class Category < ApplicationRecord
  has_many :bulletins, dependent: :nullify

  validates :name, presence: true, uniqueness: true, length: { in: 2..30 }

  def self.ransackable_attributes(auth_object = nil)
    [ 'id' ]
  end
end
