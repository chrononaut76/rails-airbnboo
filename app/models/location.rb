class Location < ApplicationRecord
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
