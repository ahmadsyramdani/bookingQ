# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, :phone_number, presence: true
  validates :phone_number, format: { with: /\+?([ -]?\d+)+|\(\d+\)([ -]\d+)/ }

  has_many :bookings
end
