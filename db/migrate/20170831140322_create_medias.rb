# frozen_string_literal: true

class CreateMedias < ActiveRecord::Migration[5.1]
  def change
    create_table :medias do |t|
      t.string :description

      t.timestamps
    end
    add_index :medias, unique: true
  end
end
