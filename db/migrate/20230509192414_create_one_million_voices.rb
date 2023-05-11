# frozen_string_literal: true

class CreateOneMillionVoices < ActiveRecord::Migration[7.0]
  def change
    create_table :one_million_voices do |t|
      t.text :description
      t.references :local, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
