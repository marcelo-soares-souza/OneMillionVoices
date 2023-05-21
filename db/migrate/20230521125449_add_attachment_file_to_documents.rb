# frozen_string_literal: true

class AddAttachmentFileToDocuments < ActiveRecord::Migration[7.0]
  def self.up
    change_table :documents do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :documents, :file
  end
end
