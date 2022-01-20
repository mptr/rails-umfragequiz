require 'test_helper'

class RearrangeableQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      RearrangeableQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false,
        answer_options: ["A", "B", "C", "D"]
      )
  end
  include AbstractClassTest
end

module RearrangeableQuestionTests
  def test_no_empty_answer_option
    @q.answer_options = ["A", "", "C", "D"]
    assert_not @q.save, 'Saved with empty answer_option'
  end

  def test_should_have_at_least_one_answer_option
    @q.answer_options = []
    assert_not @q.save, 'Saved without answer_options'
    @q.answer_options.append('TestAnswerOption')
    assert @q.save, 'Failed to save with an answer_option'
  end

  def test_should_keep_order_of_answer_options
    @q.answer_options.append('b')
    @q.answer_options.append('a')
    assert @q.save, 'Failed to save with two answer_options'
    assert_equal %w[b a], @q.answer_options, 'Failed to keep order of answer_options'
    @q.answer_options.sort
    @q.save
    q_restore = PrioQuestion.last
    assert_equal %w[a b], q_restore.answer_options, 'Failed to keep order of answer_options after reorder'
  end
end
