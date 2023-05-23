# frozen_string_literal: true

class Practice < ApplicationRecord
  paginates_per 4

  has_one :what_you_do, dependent: :delete
  has_one :characterise, dependent: :delete
  has_one :evaluate, dependent: :delete
  has_one :acknowledge, dependent: :delete

  has_many :medias, dependent: :delete_all
  has_many :documents, dependent: :delete_all

  belongs_to :account
  belongs_to :location

  validates :name, presence: true
  validates_length_of :name, minimum: 4
  validates_length_of :name, maximum: 100

  extend FriendlyId
  friendly_id :name, use: :slugged

  def default_image_number
    rand(0..5)
  end

  has_attached_file :photo,
                    styles: { original: "1920x>", medium: "360x360>", thumb: "180x180>" },
                    default_url: ->(a) { "/assets/place_:style_#{a.instance.default_image_number}.png" }
  validates_attachment_content_type :photo, content_type: %r{\Aimage/.*\z}

  before_save do
    self.name = name.strip.titleize
  end

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end
end
