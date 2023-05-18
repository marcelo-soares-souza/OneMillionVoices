# frozen_string_literal: true

class Evaluate < ApplicationRecord
  belongs_to :practice
  validates :practice, presence: true

  validates :general_performance_of_practice, presence: true
end
