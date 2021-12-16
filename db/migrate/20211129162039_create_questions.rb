class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      # STI Feld
      t.string :type, null: false
    
      # NumberRangeQuestion Felder
      t.decimal :from
      t.decimal :to
      t.decimal :step

      # MultipleChoiceQuestion Felder
      t.integer :upTo

      # RearrangeableQuestion Felder
      t.string :answerOptions # json
      # LikertQuestion Felder
      t.string :questions # json

      # eigene Felder
      t.boolean :optional, null: false
      t.string :description, null: false
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
