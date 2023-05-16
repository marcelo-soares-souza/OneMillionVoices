# frozen_string_literal: true

class AddAgroecologicalPracticeToMidia < ActiveRecord::Migration[7.0]
  def change
    add_reference :midias, :agroecological_practice, foreign_key: true
  end
end
