# frozen_string_literal: true

class Document < ApplicationRecord
  paginates_per 4

  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false

  validates :file, presence: true
  validates_length_of :description, maximum: 100

  before_save do
    self.description = description.strip.titleize
  end

  has_attached_file :file
  validates_attachment_content_type :file, content_type: ["application/pdf"]
end
