# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def map
    @locations = Location.where(hide_my_location: false).includes(:medias, :practices).with_attached_photo.load_async
  end
end
