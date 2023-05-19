# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @locais = Local.where(hide_my_location: false).includes(:midias, :practices).load_async
  end
end
