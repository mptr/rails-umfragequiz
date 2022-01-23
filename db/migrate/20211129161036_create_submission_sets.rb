class CreateSubmissionSets < ActiveRecord::Migration[6.1]
	def change
		create_table :submission_sets do |t|
			t.references :user, null: false, foreign_key: true
			t.references :survey, null: false, foreign_key: true

			t.timestamps
		end
	end
end
