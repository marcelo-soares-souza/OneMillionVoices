# frozen_string_literal: true

class Practice < ApplicationRecord
  paginates_per 4

  has_one :what_you_do, dependent: :delete
  has_one :characterise, dependent: :delete
  has_one :evaluate, dependent: :delete
  has_one :acknowledge, dependent: :delete

  has_many :medias, dependent: :delete_all
  has_many :documents, dependent: :delete_all

  has_one_attached :photo do |attachable|
    attachable.variant :original, resize_to_limit: [1920, nil]
    attachable.variant :medium, resize_to_limit: [600, nil]
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end

  belongs_to :account
  belongs_to :location

  validates :name, presence: true
  validates_length_of :name, minimum: 4
  validates_length_of :name, maximum: 100
  validate :acceptable_photo

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save do
    self.name = name.strip.capitalize
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
