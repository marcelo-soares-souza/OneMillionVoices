# frozen_string_literal: true

class CreateLocationAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :location_accounts do |t|
      t.references :location, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
