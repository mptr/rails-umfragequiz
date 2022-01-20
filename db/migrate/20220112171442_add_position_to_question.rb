class AddPositionToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :position, :integer
    Survey.all.each do |survey|
      survey.questions.order(:updated_at).each.with_index(1) do |question, index|
        question.update_column :position, index
      end
    end
  end
end

# from https://github.com/brendon/acts_as_list