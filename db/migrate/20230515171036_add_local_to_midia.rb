# frozen_string_literal: true

class AddLocalToMidia < ActiveRecord::Migration[7.0]
  def change
    add_reference :midias, :local, foreign_key: true
  end
end
