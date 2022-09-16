class User < ApplicationRecord
	before_create :generate_auth_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, presence: true, length: { maximum: 50}

  has_many :rooms
  has_many :reservations

  has_many :guest_reviews, class_name: "GuestReviews", foreign_key: "guest_id"
  has_many :host_reviews, class_name: "HostReviews", foreign_key: "host_id"

	def generate_auth_token
		begin
			self.auth_token = Devise.friendly_token
		end while self.class.exists?(auth_token: self.auth_token)
	end
end
