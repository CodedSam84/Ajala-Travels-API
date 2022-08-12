class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, presence: true, length: { maximum: 50}

  has_many :rooms
  has_many :reservations

  has_many :guest_reviews, class_name: "GuestReviews", foreign_key: "guest_id"
  has_many :host_reviews, class_name: "HostReviews", foreign_key: "host_id"
end
