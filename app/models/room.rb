class Room < ApplicationRecord
  belongs_to :user

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bedroom, presence: true
  validates :bathroom, presence: true

  has_many_attached :photos
  has_many :reservations

  has_many :guest_reviews

  enum status: { request: 0, instant: 1 }
end
