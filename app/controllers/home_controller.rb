# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @locations = Location.where(hide_my_location: false).includes(:medias, :practices).load_async
  end
end
