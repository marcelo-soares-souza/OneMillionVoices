# frozen_string_literal: true

class Practice < ApplicationRecord
  paginates_per 25

  scope :by_name, -> (name) { where("practices.name ILIKE ?", "%#{name}%") }
  scope :by_food_system_components_addressed, -> (food_system_components_addressed) { joins(:characterise).where("characterises.food_system_components_addressed ILIKE ?", "%#{food_system_components_addressed}%") }
  scope :by_agroecology_principles_addressed, -> (agroecology_principles_addressed) { joins(:characterise).where("characterises.agroecology_principles_addressed ILIKE ?", "%#{agroecology_principles_addressed}%") }
  scope :by_where_it_is_realized, -> (where_it_is_realized) { joins(:what_you_do).where("what_you_dos.where_it_is_realized ILIKE ?", "%#{where_it_is_realized}%") }
  scope :by_knowledge_source, -> (knowledge_source) { joins(:acknowledge).where("acknowledges.knowledge_source ILIKE ?", "%#{knowledge_source}%") }
  scope :by_farm_and_farming_system, -> (farm_and_farming_system) { joins(:location).where("locations.farm_and_farming_system ILIKE ?", "%#{farm_and_farming_system}%") }
  scope :by_farm_and_farming_system_complement, -> (farm_and_farming_system_complement) { joins(:location).where("locations.farm_and_farming_system_complement ILIKE ?", "%#{farm_and_farming_system_complement}%") }
  scope :by_country, -> (country) { joins(:location).where("locations.country ILIKE ?", "%#{country}%") }
  scope :by_continent, -> (continent) { joins(:location).where("locations.continent ILIKE ?", "%#{continent}%") }
  scope :by_substitution_of_less_ecological_alternative, -> (substitution_of_less_ecological_alternative) { joins(:what_you_do).where("what_you_dos.substitution_of_less_ecological_alternative ILIKE ?", "%#{substitution_of_less_ecological_alternative}%") }
  scope :by_does_it_help_restore_land, -> (does_it_help_restore_land) { joins(:evaluate).where("evaluates.does_it_help_restore_land ILIKE ?", "%#{does_it_help_restore_land}%") }
  scope :by_does_it_work_in_degraded_environments, -> (does_it_work_in_degraded_environments) { joins(:evaluate).where("evaluates.does_it_work_in_degraded_environments ILIKE ?", "%#{does_it_work_in_degraded_environments}%") }
  scope :by_knowledge_and_skills_required_for_practice, -> (knowledge_and_skills_required_for_practice) { joins(:evaluate).where("evaluates.knowledge_and_skills_required_for_practice ILIKE ?", "%#{knowledge_and_skills_required_for_practice}%") }

  has_one :what_you_do, dependent: :destroy
  has_one :characterise, dependent: :destroy
  has_one :evaluate, dependent: :destroy
  has_one :acknowledge, dependent: :destroy

  has_many :medias, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :photo do |attachable|
    attachable.variant :original, resize_to_limit: [1920, nil]
    attachable.variant :medium, resize_to_limit: [600, nil]
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end

  belongs_to :account
  belongs_to :location

  validates :name, presence: true
  validates_length_of :name, minimum: 2
  validates_length_of :name, maximum: 255
  validate :acceptable_photo

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save do
    self.name = name.strip
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
