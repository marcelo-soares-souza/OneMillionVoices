# frozen_string_literal: true

class AddFarmAndFarmingSystemToLocal < ActiveRecord::Migration[7.0]
  def change
    add_column :locais, :farm_and_farming_system, :string
  end
end
