# frozen_string_literal: true

class AddHideMyLocationToLocal < ActiveRecord::Migration[7.0]
  def change
    add_column :locais, :hide_my_location, :boolean
  end
end
