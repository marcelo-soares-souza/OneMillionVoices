# frozen_string_literal: true

class Practice < ApplicationRecord
  paginates_per 6
  max_paginates_per 6

  has_one :what_you_do, dependent: :delete
  has_one :characterise, dependent: :delete
  has_one :evaluate, dependent: :delete
  has_one :acknowledge, dependent: :delete

  has_many :midias, dependent: :delete_all

  belongs_to :usuario
  belongs_to :local

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end
end
