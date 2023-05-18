# frozen_string_literal: true

class Midia < ApplicationRecord
  before_save :concatenate_details

  belongs_to :local, required: false
  belongs_to :practice, required: false

  extend FriendlyId
  friendly_id :description, use: :slugged

  validates :description, presence: true, uniqueness: true
  validates_length_of :description, minimum: 3

  validates :imagem, presence: true

  has_attached_file :imagem, styles: { original: "1440>", medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :imagem, content_type: %r{\Aimage/.*\z}

  protected
    def should_generate_new_friendly_id?
      description_changed?
    end
    def concatenate_details
      instant = Time.now.strftime("%Y-%m-%d %T")
      self.description = "#{description} (#{instant})"
    end
end
