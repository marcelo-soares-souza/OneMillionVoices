# frozen_string_literal: true

class OneMillionVoice < ApplicationRecord
  belongs_to :local
  belongs_to :usuario

  before_save do
    self.principles.gsub!(/[\[\]\"]/, "") if attribute_present?("principles")
  end

  validates :description, presence: true
end
