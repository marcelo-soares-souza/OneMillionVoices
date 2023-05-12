# frozen_string_literal: true

class AddGeneralEvaluateToOneMillionVoices < ActiveRecord::Migration[7.0]
  def change
    add_column :one_million_voices, :general_evaluate, :text
  end
end
