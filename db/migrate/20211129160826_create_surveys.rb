class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.datetime :from_date
      t.datetime :to_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
