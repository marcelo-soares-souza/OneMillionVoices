# frozen_string_literal: true

class Usuario < ApplicationRecord
  paginates_per 6
  max_paginates_per 6

  has_many :usuarios
  has_many :locais
  has_many :local_usuarios, dependent: :destroy
  has_many :colaboracoes, through: :local_usuarios, source: :local

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates_length_of :name, minimum: 2
  validates_length_of :name, maximum: 256
  validates :name, format: { with: /\w+ \w+/, message: "Inform Your First and Last Name" }
  validates :email, presence: true, uniqueness: true

  before_save do
    self.name = name.titleize
    self.email = email.strip.downcase
  end

  def default_image_number
    # rand(1..9)
    id.to_s.last
  end

  has_attached_file :imagem,
                    styles: { original: "1440x>", medium: "360x360>", thumb: "180x180>" },
                    default_url: ->(a) { "/assets/avatar_:style_#{a.instance.default_image_number}.png" }
  validates_attachment_content_type :imagem, content_type: %r{\Aimage/.*\z}

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end
end
