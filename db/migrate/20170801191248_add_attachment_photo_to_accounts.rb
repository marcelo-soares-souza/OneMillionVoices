# frozen_string_literal: true

class AddAttachmentPhotoToAccounts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :accounts do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :accounts, :photo
  end
end
