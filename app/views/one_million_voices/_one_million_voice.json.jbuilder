# frozen_string_literal: true

json.extract! one_million_voice, :id, :description, :local_id, :usuario_id, :created_at, :updated_at
json.url one_million_voice_url(one_million_voice, format: :json)
