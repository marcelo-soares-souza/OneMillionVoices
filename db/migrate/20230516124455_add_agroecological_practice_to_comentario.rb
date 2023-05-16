# frozen_string_literal: true

class AddAgroecologicalPracticeToComentario < ActiveRecord::Migration[7.0]
  def change
    add_reference :comentarios, :agroecological_practice, null: false, foreign_key: true
  end
end
