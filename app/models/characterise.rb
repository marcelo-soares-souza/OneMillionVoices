class Characterise < ApplicationRecord
  belongs_to :practice

  before_save do
    self.agroecology_principles_addressed.gsub!(/[\[\]"]/, "") if attribute_present?("agroecology_principles_addressed")
  end
end
