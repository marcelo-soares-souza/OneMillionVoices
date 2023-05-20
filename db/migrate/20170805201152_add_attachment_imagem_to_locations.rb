# frozen_string_literal: true

class AddAttachmentImagemToLocations < ActiveRecord::Migration[5.1]
  def self.up
    change_table :locations do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :locations, :imagem
  end
end
