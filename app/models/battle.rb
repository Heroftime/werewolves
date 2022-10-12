class Battle < ApplicationRecord
  belongs_to :initiator, class_name: "User"
  belongs_to :opponent, class_name: "User"
  belongs_to :winner, class_name: "User", optional: true

  validates :initiator, presence: true
end
