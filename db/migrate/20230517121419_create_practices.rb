class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :local, null: false, foreign_key: true
      t.text :name

      t.timestamps
    end
  end
end
