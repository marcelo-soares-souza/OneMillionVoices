class AddQuestionsToOneMillionVoices < ActiveRecord::Migration[7.0]
  def change
    add_column :one_million_voices, :problem_it_address, :text
    add_column :one_million_voices, :how_it_is_done, :text
    add_column :one_million_voices, :expected_function_effects, :text
  end
end
