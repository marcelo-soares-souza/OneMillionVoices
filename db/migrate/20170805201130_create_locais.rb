# frozen_string_literal: true

class CreateLocais < ActiveRecord::Migration[5.1]
  def change
    create_table :locais do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.float :latitude
      t.float :longitude
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :locais, :slug, unique: true
  end
end
