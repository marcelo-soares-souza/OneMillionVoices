# frozen_string_literal: true

class Media < ApplicationRecord
  before_save :concatenate_details

  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false

  validates :photo, presence: true
  validates_length_of :description, maximum: 100

  before_save do
    self.description = description.strip.titleize
  end

  has_attached_file :photo, styles: { original: "1440>", medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :photo, content_type: %r{\Aimage/.*\z}

  protected
    def concatenate_details
      instant = Time.now.strftime("%Y-%m-%d %T")
      self.description = "#{description} (#{instant})"
    end
end
