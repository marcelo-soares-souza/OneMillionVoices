# frozen_string_literal: true

class AddAccountToMidia < ActiveRecord::Migration[5.1]
  def change
    add_reference :midias, :account, foreign_key: true
  end
end
