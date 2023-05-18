# frozen_string_literal: true

class AddPropertyTypeToLocal < ActiveRecord::Migration[5.1]
  def change
    add_column :locais, :property_type, :string
  end
end
