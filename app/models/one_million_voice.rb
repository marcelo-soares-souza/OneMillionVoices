# frozen_string_literal: true

class OneMillionVoice < ApplicationRecord
  belongs_to :local
  belongs_to :usuario
  has_many :midias, dependent: :delete_all

  before_save do
    self.principles.gsub!(/[\[\]"]/, "") if attribute_present?("principles")
  end
end
