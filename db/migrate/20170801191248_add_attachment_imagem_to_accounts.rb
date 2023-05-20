# frozen_string_literal: true

class AddAttachmentImagemToAccounts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :accounts do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :accounts, :imagem
  end
end
