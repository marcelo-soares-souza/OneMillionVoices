# frozen_string_literal: true

class AddAgroecologyInPracticeSummaryObservationToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :agroecology_in_practice, :text
    add_column :locations, :summary_observation, :text
  end
end
