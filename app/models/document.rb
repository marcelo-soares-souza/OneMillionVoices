# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false

  validates :file, presence: true
  has_attached_file :file
  validates_attachment_content_type :file, content_type: ["application/pdf"]
end
