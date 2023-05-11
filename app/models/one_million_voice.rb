# frozen_string_literal: true

class OneMillionVoice < ApplicationRecord
  belongs_to :local
  belongs_to :usuario

  validates :description, presence: true
end
