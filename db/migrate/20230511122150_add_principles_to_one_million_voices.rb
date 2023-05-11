class AddPrinciplesToOneMillionVoices < ActiveRecord::Migration[7.0]
  def change
    add_column :one_million_voices, :principles, :text
  end
end
