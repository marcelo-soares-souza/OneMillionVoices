# frozen_string_literal: true

class CreateLocationUsuarios < ActiveRecord::Migration[5.1]
  def change
    create_table :location_usuarios do |t|
      t.references :location, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
