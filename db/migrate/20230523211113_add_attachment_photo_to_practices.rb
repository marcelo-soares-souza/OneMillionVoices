# frozen_string_literal: true

class AddAttachmentPhotoToPractices < ActiveRecord::Migration[7.0]
  def self.up
    change_table :practices do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :practices, :photo
  end
end
