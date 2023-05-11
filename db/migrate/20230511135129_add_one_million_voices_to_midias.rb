# frozen_string_literal: true

class AddOneMillionVoicesToMidias < ActiveRecord::Migration[7.0]
  def change
    add_reference :midias, :one_million_voice, foreign_key: true
  end
end
