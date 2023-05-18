# frozen_string_literal: true

class AddNameToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :name, :string
  end
end
