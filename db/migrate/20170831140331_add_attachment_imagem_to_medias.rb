# frozen_string_literal: true

class AddAttachmentImagemToMedias < ActiveRecord::Migration[5.1]
  def self.up
    change_table :medias do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :medias, :imagem
  end
end
