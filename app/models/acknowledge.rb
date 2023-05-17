class Acknowledge < ApplicationRecord
  belongs_to :practice
  validates :practice, :presence => true
end
