# frozen_string_literal: true

class Document < ApplicationRecord
  paginates_per 4

  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false
  has_one_attached :file, dependent: :destroy

  validates :file, presence: true
  validate :acceptable_file
  validates_length_of :description, maximum: 100

  before_save do
    self.description = description.strip.titleize
  end

  def acceptable_file
    return unless file.attached?

    unless file.blob.byte_size <= 16.megabyte
      errors.add(:photo, "Size Limit is 16 Mb")
    end

    acceptable_types = ["application/pdf"]
    unless acceptable_types.include?(file.content_type)
      errors.add(:file, "must be a PDF")
    end
  end
end
