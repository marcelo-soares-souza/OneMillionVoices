# frozen_string_literal: true

class CreateMedias < ActiveRecord::Migration[5.1]
  def change
    create_table :medias do |t|
      t.string :description
      t.string :slug

      t.timestamps
    end
    add_index :medias, :slug, unique: true
  end
end
