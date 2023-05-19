# frozen_string_literal: true

class AddProfileToUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :about, :text
    add_column :usuarios, :website, :string
  end
end
