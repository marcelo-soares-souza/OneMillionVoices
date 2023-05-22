# frozen_string_literal: true

class Media < ApplicationRecord
  paginates_per 4

  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false

  validates :photo, presence: true
  validates_with AttachmentSizeValidator, attributes: :photo, less_than: 16.megabytes
  validates_length_of :description, maximum: 100

  before_save do
    self.description = description.strip.titleize
  end

  has_attached_file :photo, styles: { original: "1440>", medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :photo, content_type: %r{\Aimage/.*\z}
end
