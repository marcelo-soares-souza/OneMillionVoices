# frozen_string_literal: true

class AddAttachmentPhotoToMedias < ActiveRecord::Migration[5.1]
  def self.up
    change_table :medias do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :medias, :photo
  end
end
