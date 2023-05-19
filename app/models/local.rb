# frozen_string_literal: true

class Local < ApplicationRecord
  paginates_per 4
  belongs_to :usuario

  has_many :local_usuarios, dependent: :destroy
  has_many :usuarios, through: :local_usuarios
  has_many :midias, dependent: :destroy
  has_many :practices, dependent: :destroy

  accepts_nested_attributes_for :local_usuarios, allow_destroy: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, minimum: 4
  validates_length_of :name, maximum: 150

  before_save do
    self.name = name.titleize
  end

  def default_image_number
    rand(0..5)
  end

  has_attached_file :imagem,
                    styles: { original: "1920x>", medium: "360x360>", thumb: "180x180>" },
                    default_url: ->(a) { "/assets/place_:style_#{a.instance.default_image_number}.png" }
  validates_attachment_content_type :imagem, content_type: %r{\Aimage/.*\z}

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end
end
