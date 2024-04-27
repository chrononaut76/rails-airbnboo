class Location < ApplicationRecord
  # the associations

  # belongs_to :user

  # the validations
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
