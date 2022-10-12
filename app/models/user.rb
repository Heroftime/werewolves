class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :initiator_battles, class_name: "Battle", foreign_key: "initiator_id"
  has_many :opponent_battles, class_name: "Battle", foreign_key: "opponent_id"
  has_many :winner_battles, class_name: "Battle", foreign_key: "winner_id"

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
