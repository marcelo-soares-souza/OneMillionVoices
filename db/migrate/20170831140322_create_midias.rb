# frozen_string_literal: true

class CreateMidias < ActiveRecord::Migration[5.1]
  def change
    create_table :midias do |t|
      t.string :description
      t.string :slug

      t.timestamps
    end
    add_index :midias, :slug, unique: true
  end
end
