# frozen_string_literal: true

class Account < ApplicationRecord
  paginates_per 6
  max_paginates_per 6

  has_many :locations, dependent: :destroy
  has_many :practices, through: :location
  has_many :documents
  has_many :medias

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates_length_of :name, minimum: 2
  validates_length_of :name, maximum: 100
  validates :name, format: { with: /\w+ \w+/, message: "Inform Your First and Last Name" }
  validates :email, presence: true, uniqueness: true
  validates_length_of :about, minimum: 4, allow_blank: true
  validates_length_of :about, maximum: 2048
  validates :website, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true

  before_save do
    self.name = name.strip.titleize
    self.email = email.strip.downcase
    self.about = about.strip.capitalize
    self.website = website.strip.downcase
  end

  def default_image_number
    # rand(1..9)
    id.to_s.last
  end

  has_attached_file :photo,
                    styles: { original: "1440x>", medium: "360x360>", thumb: "180x180>" },
                    default_url: ->(a) { "/assets/avatar_:style_#{a.instance.default_image_number}.png" }
  validates_attachment_content_type :photo, content_type: %r{\Aimage/.*\z}

  protected
    def should_generate_new_friendly_id?
      name_changed?
    end
end