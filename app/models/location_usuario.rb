# frozen_string_literal: true

class LocationUsuario < ApplicationRecord
  belongs_to :location
  belongs_to :usuario
  accepts_nested_attributes_for :location, allow_destroy: true
end
