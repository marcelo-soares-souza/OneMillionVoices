# frozen_string_literal: true

class Location < ApplicationRecord
  paginates_per 4

  belongs_to :account
  has_many :medias, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :practices, dependent: :destroy
  has_one_attached :photo do |attachable|
    attachable.variant :original, resize_to_limit: [1920, nil]
    attachable.variant :medium, resize_to_limit: [600, nil]
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, minimum: 4, maximum: 100
  validates_length_of :description, minimum: 8, maximum: 4096, allow_blank: true
  # validates_length_of :agroecology_in_practice, minimum: 8, maximum: 4096, allow_blank: true
  # validates_length_of :summary_observation, minimum: 8, maximum: 4096, allow_blank: true
  validate :acceptable_photo

  before_save do
    self.name = name.strip.titleize
    self.description = description.strip.capitalize
    # self.agroecology_in_practice = agroecology_in_practice.strip.capitalize
    # self.summary_observation = summary_observation.strip.capitalize

    self.farm_and_farming_system_complement.gsub!(/[\[\]"]/, "") if attribute_present?("farm_and_farming_system_complement")
  end

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end

    def acceptable_photo
      return unless photo.attached?

      unless photo.blob.byte_size <= 16.megabyte
        errors.add(:photo, "Size Limit is 16 Mb")
      end

      acceptable_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
      unless acceptable_types.include?(photo.content_type)
        errors.add(:photo, "must be a JPEG, PNG, GIF or WebP")
      end
    end
end
