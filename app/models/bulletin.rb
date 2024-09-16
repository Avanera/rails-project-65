class Bulletin < ApplicationRecord
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
end
