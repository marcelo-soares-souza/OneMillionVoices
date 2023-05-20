# frozen_string_literal: true

class LocationAccount < ApplicationRecord
  belongs_to :location
  belongs_to :account
  accepts_nested_attributes_for :location, allow_destroy: true
end
