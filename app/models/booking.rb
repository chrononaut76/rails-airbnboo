class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :user, :location, :status, presence: true
  validates :user, :location, :status, uniqueness: true
  enum status: { accepted: 0, pending: 1, rejected: 2 }
end
