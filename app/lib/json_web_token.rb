# frozen_string_literal: true

class JsonWebToken
  # JWT_SECRET = Rails.application.secrets.secret_key_base
  JWT_SECRET = "2342gfGFGFDg@35235!!!$wegfsdgrfsdger45r3"

  def self.encode(payload, exp = 8760.hours.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, JWT_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, JWT_SECRET)[0]

    HashWithIndifferentAccess.new(body)
  end
end
