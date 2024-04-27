class Location < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
