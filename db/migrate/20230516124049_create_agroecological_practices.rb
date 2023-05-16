# frozen_string_literal: true

class CreateAgroecologicalPractices < ActiveRecord::Migration[7.0]
  def change
    create_table :agroecological_practices do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :local, null: false, foreign_key: true
      t.text :summary_description
      t.text :problem_it_address
      t.text :how_it_is_done
      t.text :expected_function_effects
      t.text :principles
      t.text :general_evaluate

      t.timestamps
    end
  end
end
