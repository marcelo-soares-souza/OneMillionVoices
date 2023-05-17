class AddPracticeToMidia < ActiveRecord::Migration[7.0]
  def change
    add_reference :midias, :practice, null: false, foreign_key: true
  end
end
