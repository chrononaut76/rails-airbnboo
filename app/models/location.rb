class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # the associations

  belongs_to :user

  include PgSearch::Model

  pg_search_scope :search_by_name_address_description,
    against: [:name, :address, :description],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  # the validations
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
