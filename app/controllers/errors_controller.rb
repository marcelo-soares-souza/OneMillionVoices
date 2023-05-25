# frozen_string_literal: true

class ErrorsController < ApplicationController
  rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_invalid_authenticity_token
  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  def unprocessable_entity
    render status: 422
  end
end
