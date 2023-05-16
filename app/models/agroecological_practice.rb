# frozen_string_literal: true

class AgroecologicalPractice < ApplicationRecord
  paginates_per 6
  max_paginates_per 6

  belongs_to :usuario
  belongs_to :local

  has_many :comentarios
  has_many :midias, dependent: :delete_all

  before_save do
    self.principles.gsub!(/[\[\]"]/, "") if attribute_present?("principles")
  end
end
