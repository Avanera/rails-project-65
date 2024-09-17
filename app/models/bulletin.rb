class Bulletin < ApplicationRecord
  include AASM

  MAX_IMAGE_SIZE_MB = 5

  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 200, 100 ]
  end

  validates :title, length: { in: 2..50 }
  validates :description, length: { in: 5..1000 }
  validates :image,
            attached: true,
            size: { less_than: MAX_IMAGE_SIZE_MB.megabytes },
            content_type: [ 'image/png', 'image/jpg', 'image/jpeg' ]

  aasm do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: [ :draft, :under_moderation, :published, :rejected ], to: :archived
    end
  end

  scope :published_or_created_by, ->(author) { where(user_id: author.id) }
end
