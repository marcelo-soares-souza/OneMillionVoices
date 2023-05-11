# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @locais = Local.all.includes(:midias, :one_million_voice).load_async
  end
end
