# frozen_string_literal: true

class AddPropertyTypeToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :property_type, :string
  end
end
