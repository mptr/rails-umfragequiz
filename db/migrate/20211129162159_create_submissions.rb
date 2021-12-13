class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :submissions do |t|
      # STI Feld
      t.string :type, null: false

      # StringSubmission
      t.string :answer_string
      # NumberSubmission
      t.decimal :answer_number

      t.references :submission_set, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
