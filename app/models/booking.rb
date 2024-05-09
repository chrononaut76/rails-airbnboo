class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :user, :location, :status, presence: true
  # validates :user, :location, :status, uniqueness: true
  enum status: { available: 0, pending: 1, accepted: 2, rejected: 3 }
end
