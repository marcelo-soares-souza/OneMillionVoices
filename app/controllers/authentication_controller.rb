# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def login
    account = Account.find_by(email: params[:email])
    isValid = account.valid_password?(params[:password]) unless account.nil?

    if isValid
      token = JsonWebToken.encode(account_id: account.id)
      expires_at = JsonWebToken.decode(token)[:exp]

      render json: { token:, expires_at: }, status: :ok
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end
end
