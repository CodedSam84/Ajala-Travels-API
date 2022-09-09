class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  enum status: { waiting: 0, approve: 1, decline: 2 }
end
