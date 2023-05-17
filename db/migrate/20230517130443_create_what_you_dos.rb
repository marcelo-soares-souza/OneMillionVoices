# frozen_string_literal: true

class CreateWhatYouDos < ActiveRecord::Migration[7.0]
  def change
    create_table :what_you_dos do |t|
      t.references :practice, null: false, foreign_key: true
      t.text :summary_description_of_agroecological_practice
      t.text :type_of_agroecological_practice
      t.text :problem_that_practice_addresses
      t.text :practical_implementation_of_the_practice
      t.text :expected_function_or_effects_of_practice

      t.timestamps
    end
  end
end