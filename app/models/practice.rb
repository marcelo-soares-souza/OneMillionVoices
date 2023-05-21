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
  validates_length_of :name, maximum: 256

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save do
    self.name = name.titleize
  end

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end
end
